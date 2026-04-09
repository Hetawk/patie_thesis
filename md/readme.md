we are working on this
MedDef: An Attention-Based Model for Adversarial Resilience in Medical Imaging

as our thesis

and my table of content is more like this
目  录

Chapter 1  Introduction
1.1  Background on Medical Imaging and Adversarial Threats
1.2  Problem Statement and Motivation
1.3  Research Objectives and Significance
1.4  Feasibility Analysis
1.4.1  Technical Feasibility
1.4.2  Economic Feasibility
1.4.3  Demand Analysis
1.5  Thesis Structure

Chapter 2  Literature Review
2.1  Medical Imaging Modalities and Challenges
2.2  Adversarial Attacks in Deep Learning
2.3  Attention Mechanisms and Transformer Models
2.4  Defenses Against Adversarial Attacks
2.5  Research Gaps

Chapter 3  Methodology and Experimental Design
3.1  MedDef Architecture Overview
3.2  Dataset and Preprocessing
3.3  Adversarial Attack Generation
3.4  Training and Optimization
3.5  Evaluation Metrics

Chapter 4  Experimental Results and Analysis
4.1  Baseline Performance and Adversarial Robustness
4.2  Ablation Study of Attention Modules
4.3  Comparative Evaluation Against Existing Methods
4.4  Model Efficiency and Inference Time
4.5  Visualization and Interpretability (Attention Maps)

Chapter 5   Conclusion
5.1  Discussion of Key Findings
5.2  Practical Implications and Ethical Considerations
5.3  Limitations of the Study
5.4  Future Work
5.5  Conclusion

References
Acknowledgments
Appendix

But note that i am having 3 different experiments
the first experiment i am talking more about this 

MedDef: An Efficient Self-Attention Model for Adversarial Resilience in Medical Imaging with Unstructured Pruning

while the second experiment i am talking amore about this

Enhanced Medical Image Security with TCBAM and Defensive Distillation in Vision Transformers

for the third experiment it is not concluded on yet but i did talk about some of it in my openinig report and i will share some points on it the third experiment is more like combining the major methods from the first and second experiment and it will be more like ensemble. we can give it a better name. 

An Ensemble Model for Enhanced Adversarial Resilience in Medical Imaging

or something better

now, can we make sure that each chapter and thier content are written in the chapter dir that is here chapter/ 
(base) ➜  ujn git:(master) ✗ cd chapter/ && tree && cd reference_me/ && tree
.
├── 0_abstract.tex
├── 1_introduction.tex
├── 6_conclustion.tex
├── 9_acknowledgement.tex
└── reference_me
    ├── 2_model_building.tex
    ├── 3_parking_space.tex
    ├── 4_car_paving.tex
    └── 5_verification.tex

2 directories, 8 files
.
├── 2_model_building.tex
├── 3_parking_space.tex
├── 4_car_paving.tex
└── 5_verification.tex

1 directory, 4 files
(base) ➜  reference_me git:(master) ✗ cd ..
(base) ➜  chapter git:(master) ✗ cd ..
(base) ➜  ujn git:(master) ✗ ls
JULS_LOGO_.png  figures          jinan_election.md             md   ujn_thesis.cls
README.MD       fonts            juls_iec_election_symbol.svg  ref
chapter         gb7714-2015.bbx  main.tex                      res
(base) ➜  ujn git:(master) ✗ pwd
/Users/hetawk/Documents/Coding_Env/latex/thesis/ujn
(base) ➜  ujn git:(master) ✗ 

note that we would like to have separate chapters for the different experiments, so we can have:
Chapter x: MedDef - An Efficient Self-Attention Model for Adversarial Resilience in Medical Imaging with Unstructured Pruning
Chapter x: Enhanced Medical Image Security with TCBAM and Defensive Distillation in Vision Transformers
Chapter x: An Ensemble Model for Enhanced Adversarial Resilience in Medical Imaging or a better name can be given for this chapter based on what we did on others and what we proposed

finally. all chapters will be imported into our main.tex file that is in here

./main.tex

we can properly update tehse information 
\classificationnum{TN384}
\studentnum{202324100003}
\degreetype{硕 士 学 位 论 文}
\degreelevel{（ 全 日 制 研 究 生）}
\thesistitle{MedDef: }
\authorname{Enoch Kwateh Dongbo}
\supervisor{牛四节}
\cosupervisor{牛四节}
\discipline{材料科学与工程}
\degreecategory{工学硕士}
\defensedate{2025年5月29日}

with the right information that are in here
md/literature_review.md md/open_report.md
even those chinese characters that needs to be corrected based on these
md/literature_review.md md/open_report.md

additionally, we will be using the content from in here

md/open_report.md md/literature_review.md md/latex_paper/exp2_paper2.tex md/latex_paper/exp1_paper1.tex
to filled the different chapters

these are 
md/latex_paper/exp1_paper1.tex md/latex_paper/exp2_paper2.tex

papers that we did already so they are more accurate the other places. we shuld prioritize them over others

the images that were in the md/literature_review.md

are the ones in this particular dir
figures/lit_rev/
(base) ➜  ujn git:(master) ✗ cd figures/lit_rev/ tree
cd: string not in pwd: figures/lit_rev/
(base) ➜  ujn git:(master) ✗ cd figures/lit_rev/ && tree
.
├── fig1.png
├── fig2.png
├── fig3.png
├── fig4.png
├── fig5.png
├── fig6.png
└── tab1_fig7.png

1 directory, 7 files
(base) ➜  lit_rev git:(master) ✗ 

this is our class
ujn_thesis.cls

that's where we are defining major components that we will reuse. note that i am making this template for a university and it will be use by the entire university for all master students

aditionally, our references are in 
ref/references.bib

fonts are in 
fonts/

figures are in 
figures/

this dir
chapter/reference_me/ can be reference so our work can see the pattern of the latex

all the content in here

chapter/ can be replace accordingly based on what we have

now we would like you to copy all the content in here
md/ that we mention an use it in our different chapters

we can also properly fix our abstract based on all our experiment and content.

lets make sure not to destroy our latex template
this is our full structure

(base) ➜  ujn git:(master) ✗ tree
.
├── JULS_LOGO_.png
├── README.MD
├── chapter
│   ├── 0_abstract.tex
│   ├── 1_introduction.tex
│   ├── 6_conclustion.tex
│   ├── 9_acknowledgement.tex
│   └── reference_me
│       ├── 2_model_building.tex
│       ├── 3_parking_space.tex
│       ├── 4_car_paving.tex
│       └── 5_verification.tex
├── figures
│   ├── adv_train.jpg
│   ├── default
│   │   ├── bottom_cover_sidebar.jpg
│   │   └── top_cover_sidebar.jpg
│   ├── exp1
│   │   ├── asr-prunning
│   │   │   ├── chest_xray
│   │   │   │   ├── 0.05_meddef1.png
│   │   │   │   ├── 0.05_no_afd.png
│   │   │   │   ├── 0.05_no_afd_mfe.png
│   │   │   │   ├── 0.05_no_afd_mfe_msf.png
│   │   │   │   ├── 0.05_resnet18.png
│   │   │   │   ├── 0.1_meddef1.png
│   │   │   │   ├── 0.1_no_afd.png
│   │   │   │   ├── 0.1_no_afd_mfe.png
│   │   │   │   ├── 0.1_no_afd_mfe_msf.png
│   │   │   │   └── 0.1_resnet18.png
│   │   │   └── roct
│   │   │       ├── 0.05_meddef1.png
│   │   │       ├── 0.05_no_afd.png
│   │   │       ├── 0.05_no_afd_mfe.png
│   │   │       ├── 0.05_no_afd_mfe_msf.png
│   │   │       ├── 0.05_resnet18.png
│   │   │       ├── 0.1_meddef1.png
│   │   │       ├── 0.1_no_afd.png
│   │   │       ├── 0.1_no_afd_mfe.png
│   │   │       ├── 0.1_no_afd_mfe_msf.png
│   │   │       └── 0.1_resnet18.png
│   │   ├── class_distribution_chest_xray.png
│   │   ├── class_distribution_roct.png
│   │   ├── cm
│   │   │   ├── chest_xray
│   │   │   │   ├── meddef1.png
│   │   │   │   ├── no_afd.png
│   │   │   │   ├── no_afd_mfe.png
│   │   │   │   ├── no_afd_mfe_msf.png
│   │   │   │   └── resnet18.png
│   │   │   └── roct
│   │   │       ├── meddef1.png
│   │   │       ├── no_afd.png
│   │   │       ├── no_afd_mfe.png
│   │   │       ├── no_afd_mfe_msf.png
│   │   │       └── resnet18.png
│   │   ├── meddef1_arch.jpg
│   │   ├── per-class
│   │   │   ├── chest_xray.png
│   │   │   └── roct.png
│   │   └── saliency_map
│   │       ├── chest_xray
│   │       │   ├── 0.png
│   │       │   ├── 1.png
│   │       │   ├── 2.png
│   │       │   ├── meddef10.png
│   │       │   ├── meddef11.png
│   │       │   ├── meddef12.png
│   │       │   ├── no_afd0.png
│   │       │   ├── no_afd1.png
│   │       │   ├── no_afd2.png
│   │       │   ├── no_afd_mfe0.png
│   │       │   ├── no_afd_mfe1.png
│   │       │   ├── no_afd_mfe2.png
│   │       │   ├── no_afd_mfe_msf0.png
│   │       │   ├── no_afd_mfe_msf1.png
│   │       │   ├── no_afd_mfe_msf2.png
│   │       │   ├── old
│   │       │   │   ├── densenet121_0.png
│   │       │   │   ├── densenet121_1.png
│   │       │   │   ├── densenet121_2.png
│   │       │   │   ├── resnet34_0.png
│   │       │   │   ├── resnet34_1.png
│   │       │   │   ├── resnet34_2.png
│   │       │   │   ├── vgg16_0.png
│   │       │   │   ├── vgg16_1.png
│   │       │   │   └── vgg16_2.png
│   │       │   ├── resnet18_0.png
│   │       │   ├── resnet18_1.png
│   │       │   └── resnet18_2.png
│   │       └── roct
│   │           ├── 0.png
│   │           ├── 1.png
│   │           ├── 2.png
│   │           ├── meddef10.png
│   │           ├── meddef11.png
│   │           ├── meddef12.png
│   │           ├── no_afd0.png
│   │           ├── no_afd1.png
│   │           ├── no_afd2.png
│   │           ├── no_afd_mfe0.png
│   │           ├── no_afd_mfe1.png
│   │           ├── no_afd_mfe2.png
│   │           ├── no_afd_mfe_msf0.png
│   │           ├── no_afd_mfe_msf1.png
│   │           ├── no_afd_mfe_msf2.png
│   │           ├── old
│   │           │   ├── densenet121_0.png
│   │           │   ├── densenet121_1.png
│   │           │   ├── densenet121_2.png
│   │           │   ├── resnet34_0.png
│   │           │   ├── resnet34_1.png
│   │           │   ├── resnet34_2.png
│   │           │   ├── vgg16_0.png
│   │           │   ├── vgg16_1.png
│   │           │   └── vgg16_2.png
│   │           ├── resnet18_0.png
│   │           ├── resnet18_1.png
│   │           └── resnet18_2.png
│   ├── exp2
│   │   ├── arch.png
│   │   ├── binary_roc
│   │   │   ├── MT-2.0_binary_roc_curve.png
│   │   │   ├── MT-2.1_binary_roc_curve.png
│   │   │   ├── MT-ND-2.0_binary_roc_curve.png
│   │   │   ├── MT-ND-2.1_binary_roc_curve.png
│   │   │   ├── MT-ND-2.2_binary_roc_curve.png
│   │   │   ├── MT-ND-CBAM-2.0_binary_roc_curve.png
│   │   │   ├── MT-ND-CBAM-2.1_binary_roc_curve.png
│   │   │   ├── MT-ND-FCBAM-2.0_binary_roc_curve.png
│   │   │   ├── MT-ND-FCBAM-2.1_binary_roc_curve.png
│   │   │   ├── MT-ND-FPCBAM-2.0_binary_roc_curve.png
│   │   │   └── MT-ND-FPCBAM-2.1_binary_roc_curve.png
│   │   ├── class_distribution.png
│   │   ├── confusion_matrix
│   │   │   ├── MT-2.0_confusion_matrix_meddef2_t_2.0_full_0.png
│   │   │   ├── MT-2.1_confusion_matrix_meddef2_t_2.1_full_0.png
│   │   │   ├── MT-ND-2.0_confusion_matrix_meddef2_t_no_defense_2.0_full_0.png
│   │   │   ├── MT-ND-2.1_confusion_matrix_meddef2_t_no_defense_2.1_full_0.png
│   │   │   ├── MT-ND-2.2_confusion_matrix_meddef2_t_no_defense_2.2_full_0.png
│   │   │   ├── MT-ND-CBAM-2.0_confusion_matrix_meddef2_t_no_defense_cbam_2.0_full_0.png
│   │   │   ├── MT-ND-CBAM-2.1_confusion_matrix_meddef2_t_no_defense_cbam_2.1_full_0.png
│   │   │   ├── MT-ND-FCBAM-2.0_confusion_matrix_meddef2_t_no_defense_freq_cbam_2.0_full_0.png
│   │   │   ├── MT-ND-FCBAM-2.1_confusion_matrix_meddef2_t_no_defense_freq_cbam_2.1_full_0.png
│   │   │   ├── MT-ND-FPCBAM-2.0_confusion_matrix_meddef2_t_no_defense_freq_patch_cbam_2.0_full_0.png
│   │   │   └── MT-ND-FPCBAM-2.1_confusion_matrix_meddef2_t_no_defense_freq_patch_cbam_2.1_full_0.png
│   │   ├── lift_curves
│   │   │   ├── MT-2.0_lift_curve.png
│   │   │   ├── MT-2.1_lift_curve.png
│   │   │   ├── MT-ND-2.0_lift_curve.png
│   │   │   ├── MT-ND-2.1_lift_curve.png
│   │   │   ├── MT-ND-2.2_lift_curve.png
│   │   │   ├── MT-ND-CBAM-2.0_lift_curve.png
│   │   │   ├── MT-ND-CBAM-2.1_lift_curve.png
│   │   │   ├── MT-ND-FCBAM-2.0_lift_curve.png
│   │   │   ├── MT-ND-FCBAM-2.1_lift_curve.png
│   │   │   ├── MT-ND-FPCBAM-2.0_lift_curve.png
│   │   │   └── MT-ND-FPCBAM-2.1_lift_curve.png
│   │   ├── per_class_metrics
│   │   │   ├── MT-2.0_per_class_metrics_test.png
│   │   │   ├── MT-2.1_per_class_metrics_test.png
│   │   │   ├── MT-ND-2.0_per_class_metrics_test.png
│   │   │   ├── MT-ND-2.1_per_class_metrics_test.png
│   │   │   ├── MT-ND-2.2_per_class_metrics_test.png
│   │   │   ├── MT-ND-CBAM-2.0_per_class_metrics_test.png
│   │   │   ├── MT-ND-CBAM-2.1_per_class_metrics_test.png
│   │   │   ├── MT-ND-FCBAM-2.0_per_class_metrics_test.png
│   │   │   ├── MT-ND-FCBAM-2.1_per_class_metrics_test.png
│   │   │   ├── MT-ND-FPCBAM-2.0_per_class_metrics_test.png
│   │   │   └── MT-ND-FPCBAM-2.1_per_class_metrics_test.png
│   │   ├── roc_curves
│   │   │   ├── MT-2.0_roc_auc_meddef2_t_2.0.png
│   │   │   ├── MT-2.1_roc_auc_meddef2_t_2.1.png
│   │   │   ├── MT-ND-2.0_roc_auc_meddef2_t_no_defense_2.0.png
│   │   │   ├── MT-ND-2.1_roc_auc_meddef2_t_no_defense_2.1.png
│   │   │   ├── MT-ND-2.2_roc_auc_meddef2_t_no_defense_2.2.png
│   │   │   ├── MT-ND-CBAM-2.0_roc_auc_meddef2_t_no_defense_cbam_2.0.png
│   │   │   ├── MT-ND-CBAM-2.1_roc_auc_meddef2_t_no_defense_cbam_2.1.png
│   │   │   ├── MT-ND-FCBAM-2.0_roc_auc_meddef2_t_no_defense_freq_cbam_2.0.png
│   │   │   ├── MT-ND-FCBAM-2.1_roc_auc_meddef2_t_no_defense_freq_cbam_2.1.png
│   │   │   ├── MT-ND-FPCBAM-2.0_roc_auc_meddef2_t_no_defense_freq_patch_cbam_2.0.png
│   │   │   └── MT-ND-FPCBAM-2.1_roc_auc_meddef2_t_no_defense_freq_patch_cbam_2.1.png
│   │   └── threshold_optimization
│   │       ├── MT-2.0_threshold_optimization.png
│   │       ├── MT-2.1_threshold_optimization.png
│   │       ├── MT-ND-2.0_threshold_optimization.png
│   │       ├── MT-ND-2.1_threshold_optimization.png
│   │       ├── MT-ND-2.2_threshold_optimization.png
│   │       ├── MT-ND-CBAM-2.0_threshold_optimization.png
│   │       ├── MT-ND-CBAM-2.1_threshold_optimization.png
│   │       ├── MT-ND-FCBAM-2.0_threshold_optimization.png
│   │       ├── MT-ND-FCBAM-2.1_threshold_optimization.png
│   │       ├── MT-ND-FPCBAM-2.0_threshold_optimization.png
│   │       └── MT-ND-FPCBAM-2.1_threshold_optimization.png
│   ├── lit_rev
│   │   ├── fig1.png
│   │   ├── fig2.png
│   │   ├── fig3.png
│   │   ├── fig4.png
│   │   ├── fig5.png
│   │   ├── fig6.png
│   │   └── tab1_fig7.png
│   └── unst_pruning_flow.jpg
├── fonts
│   ├── AdobeFangsongStd.otf
│   ├── AdobeHeitiStd.otf
│   ├── AdobeKaitiStd.otf
│   ├── AdobeSongStd.otf
│   ├── times.ttf
│   ├── timesbd.ttf
│   ├── timesbi.ttf
│   └── timesi.ttf
├── gb7714-2015.bbx
├── jinan_election.md
├── juls_iec_election_symbol.svg
├── main.tex
├── md
│   ├── doc
│   │   ├── DONGBO-ENOCH-KWATEH_MedDef An Attention-Based Model for Adversarial Resilience in Medical Imaging_Opening-Report.docx
│   │   └── Literature Review_202324100003_ENOCH-KWATEH-DONGBO_MedDef - An Attention-Based Model for Adversarial Resilience in Medical Imaging.docx
│   ├── latex_paper
│   │   ├── exp1_paper1.tex
│   │   └── exp2_paper2.tex
│   ├── literature_review.md
│   ├── open_report.md
│   └── readme.md
├── ref
│   └── references.bib
├── res
│   ├── integrity_statement.pdf
│   ├── integrity_statement_alt.pdf
│   └── integrity_statement_v15.pdf
└── ujn_thesis.cls

32 directories, 202 files
(base) ➜  ujn git:(master) ✗ 

let's make sure to use all figures accordingly and other content that we have  in a better way and robustly

can we do the work now