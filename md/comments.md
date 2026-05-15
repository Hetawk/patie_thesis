# Comments #1

## 中文原文

### 基本信息

- 论文编号：20232111E1003
- 学校：浙江理工大学
- 文档：硕士学位论文评阅意见书
- 论文题目：Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index
- 学科专业：应用经济学

### 学术型硕士学位论文质量评审表

| 评议项目                                    | 权重 | 评分标准                                                                                                                       | 具体得分（百分制） |
| ------------------------------------------- | ---- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------ |
| 一、选题与综述（A）                         | 20%  | 选题具有前瞻性，研究对象和目标明确，研究可行性高，文献翔实、权威，材料选取客观，综述全面。                                     | 80                 |
| 二、研究方案、实验设计、数据处理与结论（B） | 30%  | 专业知识体系牢固；研究方法新颖，设计合理，论证充分，研究重点突出、明确，概念界定准确，内容深入；实验数据真实、可靠，结论正确。 | 75                 |
| 三、论文的严谨性和写作水平（C）             | 20%  | 层次清晰，文字精炼准确、流畅；格式符合规范要求，文字、符号使用正确。                                                           | 74                 |
| 四、学术成果（D）                           | 30%  | 有重要或突破性成果，有新见解、新思想，或能应用新技术解决重要问题。                                                             | 75                 |

- 总分：总分 = 0.2A + 0.3B + 0.2C + 0.3D = 76.0

### 评阅意见

论文选题聚焦新兴经济体资本市场自由化与企业数字化转型的交叉领域，以中国A股分阶段纳入MSCI新兴市场指数为准自然实验，基于2010-2022年间2,712家上市公司数据，运用双重差分、事件研究及倾向得分匹配等方法，系统考察资本市场自由化对企业数字化转型的因果效应，选题具有重要的理论创新性与现实政策价值。论文创新性地将计算文本分析与准实验计量方法相结合，构建基于年报文本的数字化转型指数，突破了传统IT支出与专利数据在测度上的局限性；同时从融资约束缓解、外部监督强化与知识溢出三条路径进行机制检验，研究设计较为完整。实证方面，基准回归显示纳入MSCI显著促进企业数字化转型提升0.39个对数点，平行趋势检验、安慰剂检验、PSM-DID、交错DID诊断、披露长度控制及替代被解释变量等稳健性检验较为充分，结论可靠性较强。异质性分析发现高技术行业和经济发达地区效应更显著，机制检验证实融资约束与治理渠道有效，但知识溢出机制缺乏直接证据。

### 不足之处及修改意见

1. 论文以年报文本中AI、大数据、云计算等关键词词频构建数字化转型指数，但该指标本质上测度的是“披露意愿”而非“实际投入”。论文承认“MSCI纳入后企业可能策略性增加数字语言以迎合国际投资者”，但仅通过披露长度控制和0.67的IT投资相关性来回应，未能有效解决核心效度问题。特别是0.67的相关性意味着约55%的变异无法被IT投资解释，存在大量噪音。  
   改进建议：  
   （1）引入实质性验证指标，如企业数字专利占比、软件著作权数量、ERP/CRM系统采购记录等，构建“披露-实质”双维验证框架；  
   （2）采用机器学习分类器区分“战略宣示型”与“实施细节型”披露，后者（如具体技术架构、投资金额、实施时间表）更可能反映实质转型；  
   （3）在稳健性检验中剔除仅出现“数字化转型”等笼统词汇的观测值，检验结果是否依然成立。

2. 表6-4显示2018队列ATT = 0.049（p = 0.50，不显著），2019队列ATT = 0.014（p = 0.84，不显著），加权平均仅0.027；表6-5加入企业固定效应后加权平均近乎为零（-0.0004）。这与基准TWFE估计的0.394（p < 0.001）相差一个数量级，说明传统DID估计严重受“异质性处理效应下的负权重”问题扭曲。论文虽引用相关文献，却未将现代DID估计量作为基准，仍以有偏的TWFE为主报告。  
   改进建议：  
   （1）将Callaway & Sant'Anna (2021)或Sun & Abraham (2021)的组群特定ATT估计量作为基准，替代TWFE；  
   （2）明确解释为何TWFE与队列ATT差异巨大：是由于早期处理组被用作后期处理组的对照，还是处理效应随时间递减？需通过Borusyak et al. (2024)的插补估计量进行分解；  
   （3）若现代DID估计量不显著，应诚实报告并讨论政策含义的变化，而非依赖有偏估计支撑核心结论。

3. 论文强调MSCI纳入标准“基于市值、流动性和互联互通可及性”而非企业数字战略，但图3-1显示处理组与对照组在规模、市值、独立董事等维度存在巨大事前差异。尽管论文使用PSM-DID，但PSM仅改善可观测变量平衡，无法解决不可观测的选择偏差。  
   改进建议：  
   （1）补充“选择到纳入”的预测模型，检验残余选择偏差：将2017年企业特征对纳入概率进行Probit回归，报告逆米尔斯比率（IMR）并纳入主回归；  
   （2）采用Altonji et al. (2005)的选择偏差边界检验，量化不可观测偏差需达到多大程度才能解释估计结果；  
   （3）寻找更接近外生的工具变量，如MSCI指数编制规则的技术调整作为纳入概率的工具变量。

4. 表6-11显示KZ指数（综合融资约束指标）不显著（p = 0.60），但银行杠杆（-0.032）和现金流/资产（+0.020）显著。论文将三者统称为“融资约束缓解”，但KZ指数不显著实际上削弱了该渠道的整体证据。银行杠杆下降可能反映债务结构优化而非融资约束缓解（如用股权替代债务），现金流改善也可能是数字化转型结果而非原因（反向因果）。  
   改进建议：  
   （1）明确区分“融资约束缓解”与“融资结构变化”两个子假设：前者需SA指数或WW指数显著下降，后者需股权融资占比上升；  
   （2）采用工具变量法或滞后中介变量缓解反向因果：将t-1期融资指标对t期数字化转型进行回归，或寻找地区金融发展程度作为融资约束的工具变量；  
   （3）报告Sobel检验或Bootstrap中介效应检验，量化融资渠道的间接效应占比。

5. 论文以独立董事数量、独立董事比例和Top-10股权集中度HHI作为治理改善证据，但这些指标存在严重问题：中国上市公司独立董事比例受监管强制，其增加更可能是合规行为而非治理改善；Top-10 HHI下降可能反映MSCI纳入后的被动股权稀释（国际指数基金分散持股），而非主动治理优化。  
   改进建议：  
   （1）引入更具信息含量的治理指标，如分析师预测准确度、盈余管理程度、关联交易占比、大股东资金占用等；  
   （2）区分“形式治理”与“实质治理”；  
   （3）采用双重机器学习方法，在高维控制变量中识别治理渠道的因果效应。

- 评审单位：**\***
- 专业、职称：[] 博导 [] 硕导

## English Translation

### Basic Information

- Dissertation ID: 20232111E1003
- University: Zhejiang Sci-Tech University
- Document: Master’s Thesis Review Form
- Thesis Title: Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index
- Major: Applied Economics

### Quality Review Form for Academic Master’s Thesis

| Evaluation Item                                                             | Weight | Scoring Standard                                                                                                                                                                                                                       | Score (100-point scale) |
| --------------------------------------------------------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| 1. Topic Selection and Literature Review (A)                                | 20%    | The topic is forward-looking, with clear research objects and goals, high feasibility, rich and authoritative literature, objective material selection, and comprehensive review.                                                      | 80                      |
| 2. Research Plan, Experimental Design, Data Processing, and Conclusions (B) | 30%    | Solid professional knowledge system; innovative methods; reasonable design; sufficient argumentation; clear and focused priorities; accurate concept definition; in-depth content; authentic and reliable data; and valid conclusions. | 75                      |
| 3. Rigor and Writing Quality (C)                                            | 20%    | Clear structure; concise, accurate, and fluent writing; proper formatting; correct use of text and symbols.                                                                                                                            | 74                      |
| 4. Academic Contribution (D)                                                | 30%    | Contains important or breakthrough results, new insights/new ideas, or applies new technologies to solve important problems.                                                                                                           | 75                      |

- Total Score: Total = 0.2A + 0.3B + 0.2C + 0.3D = 76.0

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

- Review Unit: **\***
- Professional Title: [] Doctoral Supervisor [] Master’s Supervisor

---

# Defense Closure Tracker (Updated: 2026-05-15)

## Purpose

This section is a final-defense readiness checklist. It maps each reviewer concern to what has already been updated in the thesis text, what is only partially addressed, and what should be acknowledged transparently if asked by the committee.

## Comment-to-Action Status

| Reviewer Concern                                                   | Status                                                          | Current Thesis Handling                                                                                                                                                                     | Final Defense Safe Response                                                                                                                                                                |
| ------------------------------------------------------------------ | --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| R1-1 Text index may capture disclosure, not implementation         | Partially Addressed                                             | Measurement chapter and conclusion now explicitly state disclosure-versus-implementation limits; normalization and disclosure-length controls are included; interpretation is conservative. | "We treat the text index as an informative but noisy proxy, not a direct implementation measure. We explicitly report this as a limitation and avoid over-claiming structural magnitudes." |
| R1-2 TWFE vs modern DID gap                                        | Addressed in interpretation, partially in estimator replacement | Empirical chapter now treats cohort-based modern DID diagnostics as the primary magnitude anchor and TWFE as benchmark for comparability; conclusion aligned to this.                       | "Our final interpretation follows the conservative cohort ATT diagnostics; TWFE is retained only as a benchmark and no longer used as the sole substantive magnitude claim."               |
| R1-3 Residual selection bias (unobservables)                       | Partially Addressed                                             | Research design and empirical chapters now explicitly state that IMR / Altonji / IV bounds are not implemented and that endogeneity remains.                                                | "We report selection-bias boundaries transparently and frame findings as triangulated, directionally informative evidence rather than point-identified causal certainty."                  |
| R1-4 Financing channel over-interpretation with non-significant KZ | Addressed                                                       | Discussion now labels financing evidence as mixed and reframes interpretation toward funding-structure adjustment rather than broad financing-constraint relief.                            | "We no longer claim uniform financing-constraint relaxation; KZ is non-significant and the channel is interpreted as mixed."                                                               |
| R1-5 Governance proxy limitations (compliance/passive dilution)    | Addressed                                                       | Governance interpretation now includes explicit caveats on formal compliance and passive ownership dilution mechanisms.                                                                     | "Governance proxies are interpreted as suggestive and compatible with alternative institutional mechanisms; we avoid claiming definitive governance optimization."                         |
| R2 Measurement reliability/completeness concern                    | Partially Addressed                                             | Same treatment as R1-1, with stronger construct-validity caveats and conservative wording in abstract/conclusion.                                                                           | "Measurement validity is strengthened but still incomplete; this is openly documented as a limitation and future-work priority."                                                           |
| R2 Concurrent policy shocks (policy confounding)                   | Addressed with caveat                                           | Introduction/design/conclusion explicitly discuss concurrent policy confounding and acknowledge remaining time-varying unobservables.                                                       | "We control and test extensively, but we do not claim to fully remove all concurrent-policy confounding."                                                                                  |
| R2 Single-country external validity                                | Addressed                                                       | Conclusion explicitly limits generalizability beyond China and treats cross-country extension as future work.                                                                               | "External validity is bounded to institutional settings similar to China; cross-country confirmation is future work."                                                                      |
| R2 Knowledge-spillover negative finding                            | Addressed                                                       | Empirical chapter now reports this channel as deferred due to mediator data limits, not as a null effect claim.                                                                             | "We treat knowledge spillovers as theory-grounded but not directly estimated in this draft, and we avoid proxy substitution that could overstate evidence."                                |

## What Is Still Not Fully Implemented (Must Be Acknowledged If Asked)

1. No full replacement baseline using Callaway-Sant'Anna / Sun-Abraham estimator output tables as the headline baseline table.
2. No Borusyak-style decomposition to formally separate weighting artifacts versus effect dynamics.
3. No implemented IMR correction, Altonji bound, or external IV in current draft.
4. No direct new mediator dataset yet for knowledge channel (e.g., analyst coverage and foreign institutional ownership integration complete enough for final estimation).
5. No additional substantive measurement module yet (ERP/CRM procurement, software copyrights, or classifier-based rhetoric-versus-implementation split).

## Final Defense Risk-Control Rules

1. Do not describe findings as "proven causal effects"; describe them as identification-oriented and estimator-sensitive.
2. Report modern DID cohort diagnostics first when discussing effect magnitude.
3. Keep TWFE language as benchmark/comparability only.
4. State selection-bias and measurement limitations before policy implications.
5. Frame policy implications as conditional, not universal.

## Major-Limitation Decision (Implement vs Remove)

For final defense, these items should be handled by selective implementation and transparent scoping---not by deleting them from the thesis narrative.

1. Unobserved-selection bounds (IMR/Altonji/IV):
   Action now: keep as explicit boundary and explain triangulation safeguards.
   Full implementation requires: original estimation dataset + additional model pipeline; not a same-day text fix.

2. Short post-treatment horizon:
   Action now: frame as medium-run scope condition, not a fatal flaw.
   Full implementation requires: post-2022 panel extension.

3. TWFE heterogeneity sensitivity:
   Action now: keep modern DID cohort diagnostics as primary magnitude anchor and TWFE as benchmark only.
   Full implementation requires: complete replacement baseline table set with modern DID estimators.

4. Knowledge mediators and external validity:
   Action now: keep channel deferred and avoid claiming direct knowledge-channel evidence.
   Full implementation requires: analyst coverage / foreign ownership integration and multi-country extension.

---

# Comments #2

## 中文原文

### 基本信息

- 论文编号：20232111E1003
- 学校：浙江理工大学
- 文档：硕士学位论文评阅意见书
- 论文题目：Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index
- 学科专业：应用经济学

### 学术型硕士学位论文质量评审表

| 评议项目                                    | 权重 | 评分标准                                                                                                                       | 具体得分（百分制） |
| ------------------------------------------- | ---- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------ |
| 一、选题与综述（A）                         | 20%  | 选题具有前瞻性，研究对象和目标明确，研究可行性高，文献翔实、权威，材料选取客观，综述全面。                                     | 86                 |
| 二、研究方案、实验设计、数据处理与结论（B） | 30%  | 专业知识体系牢固；研究方法新颖，设计合理，论证充分，研究重点突出、明确，概念界定准确，内容深入；实验数据真实、可靠，结论正确。 | 80                 |
| 三、论文的严谨性和写作水平（C）             | 20%  | 层次清晰，文字精炼准确、流畅；格式符合规范要求，文字、符号使用正确。                                                           | 85                 |
| 四、学术成果（D）                           | 30%  | 有重要或突破性成果，有新见解、新思想，或能应用新技术解决重要问题。                                                             | 80                 |

- 总分：总分 = 0.2A + 0.3B + 0.2C + 0.3D = 82.0

### 评阅意见

选题《资本市场自由化是否推动数字化转型？来自中国A股纳入MSCI新兴市场指数的证据》兼具理论前沿性与政策迫切性。研究以中国A股分阶段纳入MSCI新兴市场指数作为准自然实验，构建了清晰的外生冲击识别策略，在因果推断方法上具有较高可信度。

从研究设计看，本文采用双重差分法为主干，辅以事件研究、倾向得分匹配等手段，有效控制了处理组与对照组在纳入前可能存在的趋势差异。动态事件研究显示处理效应在纳入后才显现且具有累积性，进一步增强了因果识别的有效性。机制检验发现融资约束缓解与外部监督强化是主要传导路径，而知识溢出机制未获支持，这一负向发现同样具有理论价值，避免了“所有好处都成立”的过度解释。

异质性分析揭示了吸收能力（高技术行业）与制度互补性（经济发达地区）对自由化收益的调节作用，使结论更具政策分层意义。值得肯定的是，本文进行了多种稳健性检验，包括安慰剂测试、分期处理诊断等，提升了结论的可靠性。

总体而言，本文在因果识别策略与机制检验方面较为严谨，为理解国际金融一体化对微观企业行为的影响提供了有价值的经验证据。

### 不足之处及修改意见

本文存在若干值得审慎看待之处。首先，数字化转型的测度依赖文本分析，其信度与维度完整性可能需要进一步验证；其次，纳入MSCI指数对企业的实际资本流动影响可能被高估，若企业本身已通过其他渠道获得国际融资，则处理效应的净识别可能受干扰；最后，研究基于中国单一国家样本，结论向其他新兴市场的推广需考虑制度环境的差异性。建议细化数字化转型的测度逻辑，强化对同期政策干扰的控制（例如2010—2022年间中国推出了“互联网+”、数字经济“十四五”规划等多项产业政策，以及沪深港通等金融市场开放举措），深入讨论机制检验的负向结果。

- 评审单位：**\***
- 专业、职称：[] 博导 [] 硕导

## English Translation

### Basic Information

- Dissertation ID: 20232111E1003
- University: Zhejiang Sci-Tech University
- Document: Master’s Thesis Review Form
- Thesis Title: Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index
- Major: Applied Economics

### Quality Review Form for Academic Master’s Thesis

| Evaluation Item                                                             | Weight | Scoring Standard                                                                                                                                                                                                                       | Score (100-point scale) |
| --------------------------------------------------------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| 1. Topic Selection and Literature Review (A)                                | 20%    | The topic is forward-looking, with clear research objects and goals, high feasibility, rich and authoritative literature, objective material selection, and comprehensive review.                                                      | 86                      |
| 2. Research Plan, Experimental Design, Data Processing, and Conclusions (B) | 30%    | Solid professional knowledge system; innovative methods; reasonable design; sufficient argumentation; clear and focused priorities; accurate concept definition; in-depth content; authentic and reliable data; and valid conclusions. | 80                      |
| 3. Rigor and Writing Quality (C)                                            | 20%    | Clear structure; concise, accurate, and fluent writing; proper formatting; correct use of text and symbols.                                                                                                                            | 85                      |
| 4. Academic Contribution (D)                                                | 30%    | Contains important or breakthrough results, new insights/new ideas, or applies new technologies to solve important problems.                                                                                                           | 80                      |

- Total Score: Total = 0.2A + 0.3B + 0.2C + 0.3D = 82.0

### Reviewer Comments

The topic, Does Capital Market Liberalization Drive Digital Transformation? Evidence from Chinese A-Shares’ Inclusion in the MSCI Emerging Markets Index, combines theoretical frontier relevance with policy urgency. The study uses the phased inclusion of Chinese A-shares in the MSCI Emerging Markets Index as a quasi-natural experiment, building a clear exogenous-shock identification strategy with high credibility for causal inference.

In terms of research design, the thesis uses DID as the backbone and supplements it with event-study and propensity score matching methods, effectively controlling potential pre-inclusion trend differences between treated and control groups. The dynamic event study shows treatment effects emerge only after inclusion and accumulate over time, further strengthening causal identification. Mechanism tests find financing-constraint relief and strengthened external monitoring as the main transmission channels, while the knowledge-spillover channel is not supported. This negative finding is also theoretically valuable because it avoids overclaiming that all benefits hold simultaneously.

Heterogeneity analysis reveals that absorptive capacity (high-tech industries) and institutional complementarity (economically developed regions) moderate gains from liberalization, making the conclusions more meaningful for tiered policy design. It is also commendable that the thesis conducts multiple robustness checks, including placebo tests and staggered-treatment diagnostics, improving the reliability of the conclusions.

Overall, the thesis is relatively rigorous in causal identification strategy and mechanism testing, and it provides valuable empirical evidence for understanding how international financial integration affects micro-level firm behavior.

### Deficiencies and Revision Suggestions

The thesis has several aspects that warrant caution. First, the measurement of digital transformation relies on text analysis, and its reliability and dimensional completeness require further validation. Second, the actual capital-flow impact of MSCI inclusion may be overestimated. If firms have already obtained international financing through other channels, net identification of treatment effects may be confounded. Third, because the study is based on a single-country sample (China), extension of conclusions to other emerging markets should account for differences in institutional environments. It is recommended to refine the measurement logic for digital transformation, strengthen controls for concurrent policy shocks (e.g., Internet Plus, the 14th Five-Year Plan for the digital economy, and financial opening initiatives such as Shanghai-Hong Kong and Shenzhen-Hong Kong Stock Connect during 2010-2022), and discuss the negative mechanism findings in greater depth.

- Review Unit: **\***
- Professional Title: [] Doctoral Supervisor [] Master’s Supervisor
