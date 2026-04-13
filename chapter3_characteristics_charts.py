"""Generate Chapter 3 data-driven charts from source data."""

from __future__ import annotations

import argparse

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
import statsmodels.api as sm
from scipy import stats


ROOT = Path(__file__).resolve().parent
DEFAULT_FIG_DIR = ROOT / "figures"

# Try local thesis dataset first, then the known source-repo dataset location.
CANDIDATE_DATA_PATHS = [
    ROOT / "dataset" / "master_dataset_english.csv",
    ROOT / "dataset" / "master_dataset_english_updated_FIXED_WINSORIZED.csv",
    Path(
        "/Users/ekd/Documents/coding/latex/patie_papers/code/dataset/"
        "master_dataset_english_updated_FIXED_WINSORIZED.csv"
    ),
    Path(
        "/Users/ekd/Documents/coding/latex/patie_papers/code/dataset/"
        "master_dataset_english.csv"
    ),
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate Chapter 3 characteristic charts and stats CSV files."
    )
    parser.add_argument(
        "--data-path",
        type=Path,
        default=None,
        help="Path to master dataset CSV. If omitted, the script auto-detects from known locations.",
    )
    parser.add_argument(
        "--fig-dir",
        type=Path,
        default=DEFAULT_FIG_DIR,
        help="Directory where figure PNG and stats CSV files are written.",
    )
    return parser.parse_args()


def resolve_data_path(user_path: Path | None) -> Path:
    if user_path is not None:
        if user_path.exists():
            return user_path
        raise FileNotFoundError(
            f"Provided data path does not exist: {user_path}")

    for candidate in CANDIDATE_DATA_PATHS:
        if candidate.exists():
            return candidate

    searched = "\n".join(str(p) for p in CANDIDATE_DATA_PATHS)
    raise FileNotFoundError(
        "Could not find a dataset file. Searched:\n"
        f"{searched}\n"
        "Use --data-path to provide the correct CSV path."
    )


def star(p_value: float) -> str:
    if p_value < 0.01:
        return "***"
    if p_value < 0.05:
        return "**"
    if p_value < 0.10:
        return "*"
    return ""


def format_p_value(p_value: float) -> str:
    if p_value == 0:
        return "<1e-300"
    if p_value < 1e-4:
        return f"{p_value:.2e}"
    return f"{p_value:.4f}"


def proportion_ci(k: int, n: int, alpha: float = 0.05) -> tuple[float, float]:
    """Clopper-Pearson exact confidence interval for binomial proportion."""
    if n == 0:
        return 0.0, 0.0
    lower = 0.0 if k == 0 else stats.beta.ppf(alpha / 2, k, n - k + 1)
    upper = 1.0 if k == n else stats.beta.ppf(1 - alpha / 2, k + 1, n - k)
    return float(lower), float(upper)


def load_data(data_path: Path) -> pd.DataFrame:
    usecols = [
        "stkcd_main",
        "year",
        "MSCI",
        "size",
        "roa",
        "IndependentDirectorNumber1",
        "HHI_A",
        "Ysmvttl_14",
        "Ysmvosd_14",
        "liqui",
    ]
    df = pd.read_csv(data_path, usecols=usecols, low_memory=False)
    ever = df.groupby("stkcd_main")["MSCI"].max().rename("ever_msci")
    return df.merge(ever, on="stkcd_main", how="left")


def make_section_31_chart(df: pd.DataFrame, fig_dir: Path) -> pd.DataFrame:
    pre = df[df["year"] <= 2017].copy()

    var_labels = {
        "size": "Firm size (log assets)",
        "Ysmvttl_14": "Total market value",
        "roa": "ROA",
        "IndependentDirectorNumber1": "Independent directors",
        "HHI_A": "Ownership concentration (HHI)",
    }

    rows = []
    for var, label in var_labels.items():
        d = pre[["ever_msci", var]].dropna().copy()
        if d.empty:
            continue
        std_all = d[var].std(ddof=0)
        if std_all == 0:
            continue
        d["z"] = (d[var] - d[var].mean()) / std_all

        treated = d.loc[d["ever_msci"] == 1, "z"]
        control = d.loc[d["ever_msci"] == 0, "z"]
        if len(treated) < 30 or len(control) < 30:
            continue

        diff = treated.mean() - control.mean()
        se = np.sqrt(treated.var(ddof=1) / len(treated) +
                     control.var(ddof=1) / len(control))
        ci_low = diff - 1.96 * se
        ci_high = diff + 1.96 * se
        p_value = stats.ttest_ind(treated, control, equal_var=False).pvalue

        rows.append(
            {
                "variable": var,
                "label": label,
                "diff_z": diff,
                "ci_low": ci_low,
                "ci_high": ci_high,
                "p_value": p_value,
                "n_treated": len(treated),
                "n_control": len(control),
            }
        )

    out = pd.DataFrame(rows).sort_values("diff_z")

    sns.set_style("whitegrid")
    fig, ax = plt.subplots(figsize=(10, 5.8))

    y = np.arange(len(out))
    ax.errorbar(
        out["diff_z"],
        y,
        xerr=[out["diff_z"] - out["ci_low"], out["ci_high"] - out["diff_z"]],
        fmt="o",
        color="#1f77b4",
        ecolor="#1f77b4",
        capsize=4,
        linewidth=1.8,
        markersize=7,
    )
    ax.axvline(0, color="black", linestyle="--", linewidth=1)

    for i, (_, r) in enumerate(out.iterrows()):
        ax.text(
            r["ci_high"] + 0.02,
            i,
            f"p={format_p_value(r['p_value'])}{star(r['p_value'])}",
            va="center",
            fontsize=9,
            color="#303030",
        )

    ax.set_yticks(y)
    ax.set_yticklabels(out["label"])
    ax.set_xlabel(
        "Standardized mean gap (ever-MSCI minus never-MSCI, pre-2018 z-units)")
    ax.set_title("Pre-liberalization structural segmentation (2010-2017)")
    ax.grid(axis="x", alpha=0.25)
    ax.grid(axis="y", alpha=0.10)

    plt.tight_layout()
    fig.savefig(
        fig_dir / "fig3_1_pre_liberalization_characteristics.png", dpi=320)
    plt.close(fig)

    out.to_csv(
        fig_dir / "fig3_1_pre_liberalization_characteristics_stats.csv", index=False)
    return out


def make_section_31_chart_alt(out: pd.DataFrame, fig_dir: Path) -> None:
    """Alternative bar+CI view for easier visual comparison."""
    view = out.sort_values("diff_z", ascending=False).reset_index(drop=True)

    sns.set_style("whitegrid")
    fig, ax = plt.subplots(figsize=(10.8, 6.2))

    y = np.arange(len(view))
    ax.barh(
        y,
        view["diff_z"],
        color="#9ecae1",
        edgecolor="#1f77b4",
        alpha=0.75,
        linewidth=1.2,
    )
    ax.hlines(y, view["ci_low"], view["ci_high"],
              color="#1f77b4", linewidth=2.0)
    ax.plot(view["diff_z"], y, "o", color="#08519c", markersize=7)
    ax.axvline(0, color="black", linestyle="--", linewidth=1)

    for i, (_, r) in enumerate(view.iterrows()):
        ax.text(
            r["ci_high"] + 0.02,
            i,
            f"p={format_p_value(r['p_value'])}{star(r['p_value'])}",
            va="center",
            fontsize=9,
            color="#303030",
        )

    ax.set_yticks(y)
    ax.set_yticklabels(view["label"])
    ax.invert_yaxis()
    ax.set_xlabel(
        "Standardized mean gap (ever-MSCI minus never-MSCI, pre-2018 z-units)")
    ax.set_title("Pre-liberalization structural segmentation (2010-2017)")
    ax.grid(axis="x", alpha=0.25)
    ax.grid(axis="y", alpha=0.08)

    plt.tight_layout()
    fig.savefig(
        fig_dir / "fig3_1_pre_liberalization_characteristics_alt_view.png",
        dpi=320,
    )
    plt.close(fig)


def make_section_32_timeline_chart(df: pd.DataFrame, fig_dir: Path) -> pd.DataFrame:
    year_total = df.groupby("year")["stkcd_main"].nunique().sort_index()
    year_msci = (
        df.loc[df["MSCI"] == 1]
        .groupby("year")["stkcd_main"]
        .nunique()
        .reindex(year_total.index, fill_value=0)
    )

    timeline = pd.DataFrame(
        {
            "year": year_total.index,
            "n_total": year_total.values,
            "n_msci": year_msci.values,
        }
    )
    timeline["share_msci"] = timeline["n_msci"] / timeline["n_total"]

    ci = timeline.apply(
        lambda r: proportion_ci(int(r["n_msci"]), int(r["n_total"])),
        axis=1,
        result_type="expand",
    )
    timeline[["share_low", "share_high"]] = ci

    sns.set_style("whitegrid")
    fig, ax1 = plt.subplots(figsize=(10.5, 5.8))
    bars = ax1.bar(
        timeline["year"],
        timeline["n_msci"],
        color="#4C78A8",
        alpha=0.85,
        width=0.72,
        label="MSCI firms in sample",
    )
    ax1.set_ylabel("Number of MSCI firms")
    ax1.set_xlabel("Year")
    ax1.set_xticks(timeline["year"])
    ax1.set_xticklabels([str(int(y)) for y in timeline["year"]], rotation=45)

    ax2 = ax1.twinx()
    ax2.plot(
        timeline["year"],
        timeline["share_msci"],
        color="#F58518",
        marker="o",
        linewidth=2,
        label="MSCI share of listed firms",
    )
    ax2.fill_between(
        timeline["year"],
        timeline["share_low"],
        timeline["share_high"],
        color="#F58518",
        alpha=0.18,
        linewidth=0,
    )
    ax2.set_ylabel("MSCI share of listed firms")
    ax2.set_ylim(0, max(timeline["share_high"].max() * 1.35, 0.13))

    for policy_year, note in [(2018, "Phase I"), (2019, "Phase II")]:
        ax1.axvline(policy_year, color="#7F7F7F",
                    linestyle="--", linewidth=1.1)
        y_note = max(timeline["n_msci"].max() * 0.90, 20)
        ax1.text(policy_year + 0.05, y_note, note, color="#555555", fontsize=9)

    for bar in bars:
        if bar.get_height() > 0:
            ax1.text(
                bar.get_x() + bar.get_width() / 2,
                bar.get_height() + 6,
                f"{int(bar.get_height())}",
                ha="center",
                va="bottom",
                fontsize=8,
            )

    ax1.set_title("MSCI inclusion rollout in the matched sample")
    ax1.grid(axis="y", alpha=0.25)

    h1, l1 = ax1.get_legend_handles_labels()
    h2, l2 = ax2.get_legend_handles_labels()
    ax1.legend(h1 + h2, l1 + l2, loc="upper left", frameon=True)

    plt.tight_layout()
    fig.savefig(fig_dir / "fig3_2_msci_rollout_timeline.png", dpi=320)
    plt.close(fig)

    timeline.to_csv(
        fig_dir / "fig3_2_msci_rollout_timeline_stats.csv", index=False)
    return timeline


def make_section_32_criteria_chart(df: pd.DataFrame, fig_dir: Path) -> pd.DataFrame:
    cs = df[df["year"] == 2017].drop_duplicates("stkcd_main").copy()
    cs["ln_total_mv"] = np.log1p(cs["Ysmvttl_14"])
    cs["ln_ff_mv"] = np.log1p(cs["Ysmvosd_14"])

    model_data = cs[["ever_msci", "ln_total_mv", "ln_ff_mv", "liqui"]].dropna()
    x = sm.add_constant(model_data[["ln_total_mv", "ln_ff_mv", "liqui"]])
    y = model_data["ever_msci"]
    result = sm.Logit(y, x).fit(disp=False)

    conf = result.conf_int()
    coef = result.params
    pvals = result.pvalues

    predictors = ["ln_total_mv", "ln_ff_mv", "liqui"]
    labels = {
        "ln_total_mv": "Log total market value",
        "ln_ff_mv": "Log free-float market value",
        "liqui": "Liquidity proxy (liqui)",
    }

    rows = []
    for p in predictors:
        rows.append(
            {
                "predictor": p,
                "label": labels[p],
                "odds_ratio": np.exp(coef[p]),
                "or_low": np.exp(conf.loc[p, 0]),
                "or_high": np.exp(conf.loc[p, 1]),
                "p_value": pvals[p],
            }
        )

    out = pd.DataFrame(rows).sort_values("odds_ratio")

    sns.set_style("whitegrid")
    fig, ax = plt.subplots(figsize=(10, 4.9))
    y_pos = np.arange(len(out))

    ax.errorbar(
        out["odds_ratio"],
        y_pos,
        xerr=[out["odds_ratio"] - out["or_low"],
              out["or_high"] - out["odds_ratio"]],
        fmt="o",
        color="#2CA02C",
        ecolor="#2CA02C",
        capsize=4,
        linewidth=1.8,
        markersize=7,
    )
    ax.axvline(1.0, color="black", linestyle="--", linewidth=1)
    ax.set_xscale("log")

    for i, (_, r) in enumerate(out.iterrows()):
        ax.text(
            r["or_high"] * 1.05,
            i,
            f"p={format_p_value(r['p_value'])}{star(r['p_value'])}",
            va="center",
            fontsize=9,
            color="#303030",
        )

    ax.set_yticks(y_pos)
    ax.set_yticklabels(out["label"])
    ax.set_xlabel("Odds ratio (log scale)")
    ax.set_title(
        "2017 eligibility-proxy evidence (logit, dependent variable: ever MSCI)")
    ax.grid(axis="x", alpha=0.25)
    ax.grid(axis="y", alpha=0.10)

    plt.tight_layout()
    fig.savefig(fig_dir / "fig3_3_eligibility_logit_odds_ratios.png", dpi=320)
    plt.close(fig)

    out.to_csv(
        fig_dir / "fig3_3_eligibility_logit_odds_ratios_stats.csv", index=False)
    return out


def make_section_32_criteria_chart_alt(out: pd.DataFrame, fig_dir: Path) -> None:
    """Alternative ln(odds-ratio) view to complement the OR log-scale chart."""
    view = out.sort_values(
        "odds_ratio", ascending=False).reset_index(drop=True).copy()
    view["ln_or"] = np.log(view["odds_ratio"])
    view["ln_low"] = np.log(view["or_low"])
    view["ln_high"] = np.log(view["or_high"])

    sns.set_style("whitegrid")
    fig, ax = plt.subplots(figsize=(10.2, 5.2))

    y = np.arange(len(view))
    ax.barh(
        y,
        view["ln_or"],
        color="#a1d99b",
        edgecolor="#2CA02C",
        alpha=0.75,
        linewidth=1.2,
    )
    ax.hlines(y, view["ln_low"], view["ln_high"],
              color="#2CA02C", linewidth=2.0)
    ax.plot(view["ln_or"], y, "o", color="#006d2c", markersize=7)
    ax.axvline(0, color="black", linestyle="--", linewidth=1)

    for i, (_, r) in enumerate(view.iterrows()):
        ax.text(
            r["ln_high"] + 0.04,
            i,
            f"p={format_p_value(r['p_value'])}{star(r['p_value'])}",
            va="center",
            fontsize=9,
            color="#303030",
        )

    ax.set_yticks(y)
    ax.set_yticklabels(view["label"])
    ax.invert_yaxis()
    ax.set_xlabel("ln(odds ratio)")
    ax.set_title(
        "2017 eligibility-proxy evidence (logit, dependent variable: ever MSCI)")
    ax.grid(axis="x", alpha=0.25)
    ax.grid(axis="y", alpha=0.08)

    plt.tight_layout()
    fig.savefig(
        fig_dir / "fig3_3_eligibility_logit_odds_ratios_alt_view.png",
        dpi=320,
    )
    plt.close(fig)


def main() -> None:
    args = parse_args()
    data_path = resolve_data_path(args.data_path)
    fig_dir = args.fig_dir

    fig_dir.mkdir(parents=True, exist_ok=True)
    df = load_data(data_path)

    sec31 = make_section_31_chart(df, fig_dir)
    make_section_31_chart_alt(sec31, fig_dir)
    sec32_timeline = make_section_32_timeline_chart(df, fig_dir)
    sec32_criteria = make_section_32_criteria_chart(df, fig_dir)
    make_section_32_criteria_chart_alt(sec32_criteria, fig_dir)

    print("Dataset used:", data_path)
    print("Generated charts in:", fig_dir)
    print("Section 3.1 chart rows:", len(sec31))
    print("Section 3.2 timeline years:", len(sec32_timeline))
    print("Section 3.2 criteria predictors:", len(sec32_criteria))
    print("Alternative views:")
    print("- fig3_1_pre_liberalization_characteristics_alt_view.png")
    print("- fig3_3_eligibility_logit_odds_ratios_alt_view.png")


if __name__ == "__main__":
    main()
