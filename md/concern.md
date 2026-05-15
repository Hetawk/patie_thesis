### Reviewer Comments

The thesis focuses on the intersection of capital market liberalization and corporate digital transformation in emerging economies. Using the phased inclusion of Chinese A-shares in the MSCI Emerging Markets Index as a quasi-natural experiment, and based on data from 2,712 listed firms during 2010-2022, it systematically examines the causal effect of capital market liberalization on corporate digital transformation through DID, event-study, and propensity score matching methods. The topic has important theoretical novelty and practical policy value.

The thesis innovatively combines computational text analysis with quasi-experimental econometrics by constructing a digital transformation index from annual report text, overcoming some limitations of traditional IT expenditure and patent-based measures. It also tests three mechanisms, financing-constraint relief, strengthened external monitoring, and knowledge spillovers, resulting in a relatively complete design. Empirically, the baseline regression suggests that MSCI inclusion significantly promotes digital transformation by 0.39 log points. Robustness checks, including parallel-trend tests, placebo tests, PSM-DID, staggered DID diagnostics, disclosure-length controls, and alternative dependent variables, are relatively sufficient, and the conclusions appear reasonably reliable. Heterogeneity analysis shows stronger effects in high-tech industries and economically developed regions. Mechanism tests confirm financing and governance channels, while direct evidence for the knowledge-spillover channel is lacking.

### Deficiencies and Revision Suggestions

1. The thesis constructs the digital transformation index from keyword frequencies (AI, big data, cloud computing, etc.) in annual reports, but this indicator essentially measures disclosure willingness rather than actual investment. The thesis acknowledges that firms may strategically increase digital language after MSCI inclusion to cater to international investors, but it responds only through disclosure-length controls and a 0.67 correlation with IT investment, which does not fully address the core validity issue. In particular, a 0.67 correlation means that about 55% of variation is not explained by IT investment, implying substantial noise.  
   Suggested improvements:  
   (1) Introduce substantive validation indicators, such as the share of digital patents, number of software copyrights, and ERP/CRM procurement records, to build a dual validation framework of disclosure vs. substance.  
   (2) Use a machine-learning classifier to distinguish strategic-declaration disclosures from implementation-detail disclosures. The latter (e.g., specific technical architecture, investment amount, implementation timeline) is more likely to reflect substantive transformation.  
   (3) In robustness checks, drop observations that only contain generic terms such as digital transformation and test whether results still hold.

2. Table 6-4 reports ATT = 0.049 (p = 0.50, insignificant) for the 2018 cohort and ATT = 0.014 (p = 0.84, insignificant) for the 2019 cohort, with a weighted average of only 0.027. Table 6-5 shows the weighted average is nearly zero (-0.0004) after adding firm fixed effects. This differs by an order of magnitude from the baseline TWFE estimate of 0.394 (p < 0.001), suggesting serious distortion from negative weighting under heterogeneous treatment effects in traditional DID. Although related literature is cited, modern DID estimators were not used as baseline, and reporting still centers on the biased TWFE estimate.  
   Suggested improvements:  
   (1) Replace TWFE baseline with group-specific ATT estimators from Callaway and Sant'Anna (2021) or Sun and Abraham (2021).  
   (2) Clearly explain why TWFE and cohort ATT differ so much: early-treated groups being used as controls for later-treated groups, or treatment effects decaying over time. Decompose this using the imputation estimator in Borusyak et al. (2024).  
   (3) If modern DID estimates are insignificant, report this transparently and discuss how policy implications change, rather than relying on biased estimates to support the core conclusion.

3. The thesis argues MSCI inclusion criteria are based on market cap, liquidity, and Stock Connect accessibility rather than firm digital strategy, but Figure 3-1 shows large pre-treatment differences between treated and control firms in size, market value, and independent directors. Although PSM-DID is used, PSM only improves balance on observable variables and cannot resolve selection bias from unobservables.  
   Suggested improvements:  
   (1) Add a selection-into-inclusion prediction model to test residual selection bias: run a Probit regression of inclusion probability on 2017 firm characteristics, report inverse Mills ratio (IMR), and include it in the main regression.  
   (2) Use the selection-bias bound test in Altonji et al. (2005) to quantify how strong unobservable bias must be to explain away the estimate.  
   (3) Seek a more exogenous instrumental variable, such as technical adjustments in MSCI index construction rules, as an instrument for inclusion probability.

4. Table 6-11 shows the KZ index (composite financing-constraint measure) is insignificant (p = 0.60), while bank leverage (-0.032) and cash flow/assets (+0.020) are significant. The thesis labels all three as financing-constraint relief, but the insignificant KZ result weakens the overall evidence for this channel. Lower bank leverage may reflect debt-structure optimization rather than easing constraints (e.g., replacing debt with equity), and improved cash flow may be an outcome rather than a cause of digital transformation (reverse causality).  
   Suggested improvements:  
   (1) Distinguish between two sub-hypotheses: financing-constraint relief and financing-structure change. The former should show significant declines in SA or WW index; the latter should show higher equity-financing share.  
   (2) Use IV methods or lagged mediators to mitigate reverse causality: regress period t digital transformation on period t-1 financing indicators, or use regional financial development as an instrument for financing constraints.  
   (3) Report Sobel or bootstrap mediation tests to quantify the share of indirect effects through financing channels.

5. The thesis uses number/share of independent directors and Top-10 ownership concentration HHI as governance-improvement evidence, but these indicators have major limitations. In China, independent-director ratios are regulator-mandated, so increases are more likely compliance than governance improvement. A decline in Top-10 HHI may reflect passive ownership dilution after MSCI inclusion (more dispersed holdings by international index funds), not active governance optimization.  
   Suggested improvements:  
   (1) Introduce more informative governance indicators, such as analyst forecast accuracy, earnings management, related-party transaction share, and controlling shareholder fund occupation.  
   (2) Distinguish formal governance from substantive governance.  
   (3) Use double machine learning to identify the causal effect of governance channels under high-dimensional controls.





### Reviewer Comments

The topic, Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index, combines theoretical frontier relevance with policy urgency. The study uses the phased inclusion of Chinese A-shares in the MSCI Emerging Markets Index as a quasi-natural experiment, building a clear exogenous-shock identification strategy with high credibility for causal inference.

In terms of research design, the thesis uses DID as the backbone and supplements it with event-study and propensity score matching methods, effectively controlling potential pre-inclusion trend differences between treated and control groups. The dynamic event study shows treatment effects emerge only after inclusion and accumulate over time, further strengthening causal identification. Mechanism tests find financing-constraint relief and strengthened external monitoring as the main transmission channels, while the knowledge-spillover channel is not supported. This negative finding is also theoretically valuable because it avoids overclaiming that all benefits hold simultaneously.

Heterogeneity analysis reveals that absorptive capacity (high-tech industries) and institutional complementarity (economically developed regions) moderate gains from liberalization, making the conclusions more meaningful for tiered policy design. It is also commendable that the thesis conducts multiple robustness checks, including placebo tests and staggered-treatment diagnostics, improving the reliability of the conclusions.

Overall, the thesis is relatively rigorous in causal identification strategy and mechanism testing, and it provides valuable empirical evidence for understanding how international financial integration affects micro-level firm behavior.

### Deficiencies and Revision Suggestions

The thesis has several aspects that warrant caution. First, the measurement of digital transformation relies on text analysis, and its reliability and dimensional completeness require further validation. Second, the actual capital-flow impact of MSCI inclusion may be overestimated. If firms have already obtained international financing through other channels, net identification of treatment effects may be confounded. Third, because the study is based on a single-country sample (China), extension of conclusions to other emerging markets should account for differences in institutional environments. It is recommended to refine the measurement logic for digital transformation, strengthen controls for concurrent policy shocks (e.g., Internet Plus, the 14th Five-Year Plan for the digital economy, and financial opening initiatives such as Shanghai-Hong Kong and Shenzhen-Hong Kong Stock Connect during 2010-2022), and discuss the negative mechanism findings in greater depth.
