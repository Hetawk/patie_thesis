from __future__ import annotations

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

plt.style.use("ggplot")

FIG_DIR = Path(__file__).resolve().parent
SHARE_TOL = 1e-6


def _require_columns(df: pd.DataFrame, required: list[str], dataset_name: str) -> None:
    missing = [col for col in required if col not in df.columns]
    if missing:
        raise ValueError(
            f"{dataset_name}: missing required columns: {missing}")


def _check_missing_values(df: pd.DataFrame, required: list[str], dataset_name: str) -> None:
    bad_cols = [col for col in required if df[col].isna().any()]
    if bad_cols:
        raise ValueError(
            f"{dataset_name}: missing values detected in columns: {bad_cols}")


def validate_fig3_1_stats(df: pd.DataFrame) -> None:
    required = [
        "label",
        "diff_z",
        "ci_low",
        "ci_high",
        "p_value",
        "n_treated",
        "n_control",
    ]
    _require_columns(df, required, "fig3_1 stats")
    _check_missing_values(df, required, "fig3_1 stats")

    bad_ci = (df["ci_low"] > df["diff_z"]) | (df["diff_z"] > df["ci_high"])
    if bad_ci.any():
        rows = df.loc[bad_ci, ["label", "ci_low",
                               "diff_z", "ci_high"]].to_dict(orient="records")
        raise ValueError(f"fig3_1 stats: invalid confidence intervals: {rows}")

    bad_p = (df["p_value"] < 0) | (df["p_value"] > 1)
    if bad_p.any():
        rows = df.loc[bad_p, ["label", "p_value"]].to_dict(orient="records")
        raise ValueError(
            f"fig3_1 stats: invalid p-values outside [0, 1]: {rows}")

    bad_n = (df["n_treated"] <= 0) | (df["n_control"] <= 0)
    if bad_n.any():
        rows = df.loc[bad_n, ["label", "n_treated",
                              "n_control"]].to_dict(orient="records")
        raise ValueError(f"fig3_1 stats: invalid sample sizes: {rows}")


def validate_fig3_2_stats(df: pd.DataFrame) -> None:
    required = ["year", "n_total", "n_msci",
                "share_msci", "share_low", "share_high"]
    _require_columns(df, required, "fig3_2 stats")
    _check_missing_values(df, required, "fig3_2 stats")

    if not df["year"].is_monotonic_increasing:
        raise ValueError(
            "fig3_2 stats: years must be sorted in ascending order")
    if df["year"].duplicated().any():
        dup_years = sorted(df.loc[df["year"].duplicated(), "year"].tolist())
        raise ValueError(
            f"fig3_2 stats: duplicate years detected: {dup_years}")

    bad_n = (df["n_total"] <= 0) | (df["n_msci"] < 0) | (
        df["n_msci"] > df["n_total"])
    if bad_n.any():
        rows = df.loc[bad_n, ["year", "n_total", "n_msci"]
                      ].to_dict(orient="records")
        raise ValueError(f"fig3_2 stats: invalid counts: {rows}")

    recomputed_share = df["n_msci"] / df["n_total"]
    abs_err = (recomputed_share - df["share_msci"]).abs()
    bad_share = abs_err > SHARE_TOL
    if bad_share.any():
        bad_df = df.loc[bad_share, [
            "year", "n_total", "n_msci", "share_msci"]].copy()
        bad_df["recomputed_share"] = recomputed_share[bad_share]
        bad_df["abs_error"] = abs_err[bad_share]
        raise ValueError(
            "fig3_2 stats: share_msci does not match n_msci / n_total for rows: "
            f"{bad_df.to_dict(orient='records')}"
        )

    bad_ci_bounds = (
        (df["share_low"] < 0)
        | (df["share_low"] > 1)
        | (df["share_high"] < 0)
        | (df["share_high"] > 1)
        | (df["share_low"] > df["share_high"])
    )
    if bad_ci_bounds.any():
        rows = df.loc[bad_ci_bounds, ["year", "share_low",
                                      "share_high"]].to_dict(orient="records")
        raise ValueError(
            f"fig3_2 stats: invalid confidence interval bounds: {rows}")

    bad_containment = (
        (df["share_msci"] + SHARE_TOL < df["share_low"])
        | (df["share_msci"] - SHARE_TOL > df["share_high"])
    )
    if bad_containment.any():
        rows = df.loc[bad_containment, ["year", "share_low",
                                        "share_msci", "share_high"]].to_dict(orient="records")
        raise ValueError(
            f"fig3_2 stats: share point estimate outside reported CI: {rows}")


def validate_fig3_3_stats(df: pd.DataFrame) -> None:
    required = ["label", "odds_ratio", "or_low", "or_high", "p_value"]
    _require_columns(df, required, "fig3_3 stats")
    _check_missing_values(df, required, "fig3_3 stats")

    non_positive = (df["odds_ratio"] <= 0) | (
        df["or_low"] <= 0) | (df["or_high"] <= 0)
    if non_positive.any():
        rows = df.loc[non_positive, ["label", "or_low",
                                     "odds_ratio", "or_high"]].to_dict(orient="records")
        raise ValueError(
            f"fig3_3 stats: odds-ratio values must be > 0 for log-scale plotting: {rows}")

    bad_ci = (df["or_low"] > df["odds_ratio"]) | (
        df["odds_ratio"] > df["or_high"])
    if bad_ci.any():
        rows = df.loc[bad_ci, ["label", "or_low",
                               "odds_ratio", "or_high"]].to_dict(orient="records")
        raise ValueError(f"fig3_3 stats: invalid confidence intervals: {rows}")

    bad_p = (df["p_value"] < 0) | (df["p_value"] > 1)
    if bad_p.any():
        rows = df.loc[bad_p, ["label", "p_value"]].to_dict(orient="records")
        raise ValueError(
            f"fig3_3 stats: invalid p-values outside [0, 1]: {rows}")


def load_fig3_1_stats() -> pd.DataFrame:
    df = pd.read_csv(
        FIG_DIR / "fig3_1_pre_liberalization_characteristics_stats.csv")
    validate_fig3_1_stats(df)
    return df.iloc[::-1].reset_index(drop=True)


def load_fig3_2_stats() -> pd.DataFrame:
    df = pd.read_csv(FIG_DIR / "fig3_2_msci_rollout_timeline_stats.csv")
    validate_fig3_2_stats(df)
    return df


def load_fig3_3_stats() -> pd.DataFrame:
    df = pd.read_csv(
        FIG_DIR / "fig3_3_eligibility_logit_odds_ratios_stats.csv")
    validate_fig3_3_stats(df)
    return df.iloc[::-1].reset_index(drop=True)


def _value_by_label(df: pd.DataFrame, label: str, column: str) -> float:
    match = df.loc[df["label"] == label, column]
    if match.empty:
        raise ValueError(f"Missing label '{label}' in column '{column}'")
    return float(match.iloc[0])


def print_validation_summary(df31: pd.DataFrame, df32: pd.DataFrame, df33: pd.DataFrame) -> None:
    size_gap = _value_by_label(df31, "Firm size (log assets)", "diff_z")
    mv_gap = _value_by_label(df31, "Total market value", "diff_z")
    indep_gap = _value_by_label(df31, "Independent directors", "diff_z")

    row_2018 = df32.loc[df32["year"] == 2018].iloc[0]
    row_2019 = df32.loc[df32["year"] == 2019].iloc[0]

    or_total_mv = _value_by_label(df33, "Log total market value", "odds_ratio")
    or_ff_mv = _value_by_label(
        df33, "Log free-float market value", "odds_ratio")
    or_liqui = _value_by_label(df33, "Liquidity proxy (liqui)", "odds_ratio")

    print("Statistical validation passed for Chapter 3 figure inputs.")
    print(
        "fig3_1 key gaps (z-units): "
        f"size={size_gap:.3f}, total_market_value={mv_gap:.3f}, independent_directors={indep_gap:.3f}"
    )
    print(
        "fig3_2 rollout checks: "
        f"2018 n_msci={int(row_2018['n_msci'])}, share={row_2018['share_msci']:.4f}; "
        f"2019 n_msci={int(row_2019['n_msci'])}, share={row_2019['share_msci']:.4f}, "
        f"95pct_CI=[{row_2019['share_low']:.4f}, {row_2019['share_high']:.4f}]"
    )
    print(
        "fig3_3 odds ratios: "
        f"log_total_mv={or_total_mv:.3f}, log_free_float_mv={or_ff_mv:.3f}, liquidity={or_liqui:.3f}"
    )


def generate_fig3_1(df: pd.DataFrame) -> None:
    y = np.arange(len(df))
    x = df["diff_z"].to_numpy()
    err_low = x - df["ci_low"].to_numpy()
    err_high = df["ci_high"].to_numpy() - x

    fig, ax = plt.subplots(figsize=(16, 10), dpi=120)
    ax.errorbar(
        x,
        y,
        xerr=[err_low, err_high],
        fmt="o",
        color="#1f77b4",
        ecolor="#1f77b4",
        elinewidth=2.2,
        capsize=8,
        markersize=12,
    )
    ax.axvline(0, color="black", linestyle="--", linewidth=2, alpha=0.85)
    ax.set_yticks(y)
    ax.set_yticklabels(df["label"], fontsize=22)
    ax.tick_params(axis="x", labelsize=18)
    ax.set_xlabel(
        "Standardized mean gap (ever-MSCI minus never-MSCI, pre-2018 z-units)",
        fontsize=21,
    )
    ax.set_title(
        "Pre-liberalization structural segmentation (2010-2017)", fontsize=28, pad=12)
    ax.grid(True, axis="both", alpha=0.25)

    for i, row in df.iterrows():
        p = float(row["p_value"])
        p_text = "p<1e-300***" if p <= 1e-300 else f"p={p:.2g}***"
        ax.text(row["ci_high"] + 0.02, i, p_text,
                va="center", ha="left", fontsize=18)

    x_left = min(-0.05, float(df["ci_low"].min()) - 0.03)
    x_right = float(df["ci_high"].max()) + 0.25
    ax.set_xlim(x_left, x_right)
    fig.tight_layout()
    fig.savefig(
        FIG_DIR / "fig3_1_pre_liberalization_characteristics.png", bbox_inches="tight")
    plt.close(fig)


def generate_fig3_2(df: pd.DataFrame) -> None:
    years = df["year"].to_numpy()

    fig, ax1 = plt.subplots(figsize=(16, 10), dpi=120)
    bars = ax1.bar(
        years,
        df["n_msci"],
        width=0.7,
        color="#4c78a8",
        alpha=0.85,
        label="MSCI firms in sample",
    )
    ax1.set_xlabel("Year", fontsize=21)
    ax1.set_ylabel("Number of MSCI firms", fontsize=21)
    ax1.tick_params(axis="both", labelsize=18)

    for bar, value in zip(bars, df["n_msci"]):
        if value > 0:
            ax1.text(
                bar.get_x() + bar.get_width() / 2,
                value + 6,
                f"{int(value)}",
                ha="center",
                va="bottom",
                fontsize=16,
            )

    ax2 = ax1.twinx()
    ax2.plot(
        years,
        df["share_msci"],
        color="#f58518",
        marker="o",
        linewidth=3,
        markersize=10,
        label="MSCI share of listed firms",
    )
    ax2.fill_between(years, df["share_low"],
                     df["share_high"], color="#f58518", alpha=0.16)
    ax2.set_ylabel("MSCI share of listed firms", fontsize=21)
    ax2.tick_params(axis="y", labelsize=18)

    ax1.axvline(2018, color="gray", linestyle="--", linewidth=2)
    ax1.axvline(2019, color="gray", linestyle="--", linewidth=2)

    y_max = float(df["n_msci"].max()) * 1.06
    ax1.text(2018.03, y_max * 0.90, "Phase I", fontsize=18, color="#444444")
    ax1.text(2019.03, y_max * 0.90, "Phase II", fontsize=18, color="#444444")

    lines_1, labels_1 = ax1.get_legend_handles_labels()
    lines_2, labels_2 = ax2.get_legend_handles_labels()
    ax1.legend(lines_1 + lines_2, labels_1 + labels_2,
               loc="upper left", fontsize=18)

    ax1.set_title("MSCI inclusion rollout in the matched sample",
                  fontsize=28, pad=10)
    fig.tight_layout()
    fig.savefig(FIG_DIR / "fig3_2_msci_rollout_timeline.png",
                bbox_inches="tight")
    plt.close(fig)


def generate_fig3_3(df: pd.DataFrame) -> None:
    y = np.arange(len(df))
    x = df["odds_ratio"].to_numpy()
    err_low = x - df["or_low"].to_numpy()
    err_high = df["or_high"].to_numpy() - x

    fig, ax = plt.subplots(figsize=(16, 10), dpi=120)
    ax.errorbar(
        x,
        y,
        xerr=[err_low, err_high],
        fmt="o",
        color="#2ca02c",
        ecolor="#2ca02c",
        elinewidth=2.2,
        capsize=8,
        markersize=12,
    )
    ax.axvline(1, color="black", linestyle="--", linewidth=2, alpha=0.85)
    ax.set_xscale("log")
    ax.set_yticks(y)
    ax.set_yticklabels(df["label"], fontsize=22)
    ax.tick_params(axis="x", labelsize=18)
    ax.set_xlabel("Odds ratio (log scale)", fontsize=21)
    ax.set_title(
        "2017 eligibility-proxy evidence (logit, dependent variable: ever MSCI)", fontsize=28, pad=12)
    ax.grid(True, which="major", axis="both", alpha=0.25)

    for i, row in df.iterrows():
        p_val = float(row["p_value"])
        ax.text(row["or_high"] * 1.05, i,
                f"p={p_val:.2g}***", va="center", ha="left", fontsize=18)

    x_left = min(0.85, float(df["or_low"].min()) * 0.9)
    x_right = float(df["or_high"].max()) * 1.35
    ax.set_xlim(x_left, x_right)
    fig.tight_layout()
    fig.savefig(FIG_DIR / "fig3_3_eligibility_logit_odds_ratios.png",
                bbox_inches="tight")
    plt.close(fig)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate and validate Chapter 3 figure files.")
    parser.add_argument(
        "--check-only",
        action="store_true",
        help="Validate CSV inputs and print summary statistics without writing PNG files.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    fig3_1_df = load_fig3_1_stats()
    fig3_2_df = load_fig3_2_stats()
    fig3_3_df = load_fig3_3_stats()
    print_validation_summary(fig3_1_df, fig3_2_df, fig3_3_df)

    if args.check_only:
        print("Check-only mode: no figure files were written.")
        return

    generate_fig3_1(fig3_1_df)
    generate_fig3_2(fig3_2_df)
    generate_fig3_3(fig3_3_df)
    print("Regenerated Chapter 3 figures: fig3_1, fig3_2, fig3_3")


if __name__ == "__main__":
    main()
