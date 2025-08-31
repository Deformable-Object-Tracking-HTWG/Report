# 1. Introduction

Deformable Object Tracking (DOT) is a challenging problem in computer vision, as it requires robustly estimating the position, shape, and motion of objects whose geometry changes over time.
Unlike Rigid Object Tracking, where the spatial configuration remains constant, deformable objects can undergo non-linear transformations such as bending, stretching, sheering or twisting.
These deformations significantly increase the complexity of the tracking process, especially in real-world environments where occlusions and lighting variations are present.

Accurate tracking of deformable objects has numerous applications, ranging from robotic manipulation of flexible materials and human motion analysis to biomedical imaging and augmented reality.
Recent advances in machine learning, particularly Deep Neural Networks, have demonstrated strong potential for capturing the complex dynamics of non-rigid motion.
However, achieving high tracking accuracy in dynamic and unconstrained scenarios remains an open research challenge.

The goal of this project is to research and develop a system for tracking deformable objects, specifically sports equipment like resistance bands and gymnastic balls.
The goal is to support physical therapists and their patients in their exercise execution with an automated, AI-driven solution.

Therefore, possible approaches are discussed in chapter 2.
Disregarding most of them because they did not fit the requirements leads to one approach called SpatialTracker ([Paper SpatialTracker](https://arxiv.org/pdf/2404.04319)) which we will be focusing on during the future work.
 Also in this chapter, the original model will be adapted, e.g, with a sliding window approach for loading longer videos and an automated segmentation for selecting the region of interest.
 The results and evaluation of the work will be stated in chapter 3.
 Two different metrics and the runtime depending on video quality and grid size of the points to track are evaluated.
 In chapter 4 the work is summarized and a brief outlook in future work is given.