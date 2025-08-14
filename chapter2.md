# Methodology and technical approach

In this section we will provide the theoretical knowledge and describe our progress throughout the two semesters.

## Previous papers

In the beginning, the team was given five papers which dealt approximately with tracking non-rigid objects:

1. Huang et al., Tracking Multiple Deformable Objects in Egocentric Videos ([Paper 1](https://openaccess.thecvf.com/content/CVPR2023/papers/Huang_Tracking_Multiple_Deformable_Objects_in_Egocentric_Videos_CVPR_2023_paper.pdf))
2. Zhang et al., Self-supervised Learning of Implicit Shape Representation with
   Dense Correspondence for Deformable Objects ([Paper 2](https://openaccess.thecvf.com/content/ICCV2023/papers/Zhang_Self-supervised_Learning_of_Implicit_Shape_Representation_with_Dense_Correspondence_for_ICCV_2023_paper.pdf))
3. Henrich et al., Registered and Segmented Deformable Object Reconstruction
   from a Single View Point Cloud ([Paper 3](https://openaccess.thecvf.com/content/WACV2024/papers/Henrich_Registered_and_Segmented_Deformable_Object_Reconstruction_From_a_Single_View_WACV_2024_paper.pdf))
4. Wang et al., Neural Textured Deformable Meshes for Robust Analysis-by-Synthesis ([Paper 4](https://openaccess.thecvf.com/content/WACV2024/papers/Wang_Neural_Textured_Deformable_Meshes_for_Robust_Analysis-by-Synthesis_WACV_2024_paper.pdf))
5. Xiao et al., SpatialTracker: Tracking Any 2D Pixels in 3D Space ([Paper 5](https://arxiv.org/pdf/2404.04319))

The task was to analyze whether one of the papers provides a useful approach for our task. Therefore, let us first consider the goals for this project:

1. Target objects of the tracking algorithm are resistance bands, gymnastic balls and smaller soft balls.
2. The work is motivated by the need to support physical therapy patients through the monitoring and assessment of correct exercise execution.
3. Most of the time one of the above mentioned objects is present in the frame. We focus more on the quality of tracking than on several objects.
4. Runtime of the approach is initially secondary.
5. The training data is mainly in 3D.

So let us have a short look on the first four papers.

Paper 1 by Huang et al. focuses on tracking multiple deformable objects in egocentric videos where the camera is mounted on a person. The method relies on template matching with learned features to track objects. This approach is problematic for tracking things like resistance bands because they undergo significant and often unpredictable deformations, including self-occlusions and changes in topology (e.g. twisting). This approach cannot handle such extreme changes as the movement of resistance bands and gymnastic ball is too complex.

Zhang et al.'s work (Paper 2) addresses self-supervised learning of implicit shape representations for deformable objects. The method is designed for learning a 3D representation from multiple views or a canonical pose. The primary goal is to establish dense correspondence for a single object, not to track its position and deformation in a dynamic video sequence. Furthermore, the objects considered in this paper, e.g. animals, are typically less flexible than a resistance band, making it unsuitable for the extreme deformations of a resistance band or a soft ball. The method would likely be too slow and would not generalize well to the continuous, unpredictable movements of sports equipment.

The paper 3 by Henrich et al. contributes to reconstructing and segmenting deformable objects from a single-view point cloud. This method is primarily concerned with 3D reconstruction, not tracking. It takes a static snapshot (a single point cloud) and tries to reconstruct the object's shape and segment it. This is a fundamentally different problem from tracking an object's movement and deformation over a sequence of video frames. While it deals with deformable objects, its single-view, static-frame nature makes it completely unsuitable for the continuous, dynamic process of tracking gym equipment in motion.

Wang et al. propose neural textured deformable meshes for robust analysis-by-synthesis. This paper focuses on reconstructing and tracking deformable objects with a pre-trained template mesh. The method requires a canonical, or rest, shape of the object. While it can track deformations, it's designed for objects whose topology remains relatively stable and predictable, such as a face or a piece of clothing. A resistance band's deformation is often so complex that it can change its topology, twisting and folding in ways that are difficult to model with a single pre-defined mesh template. A ball, while simpler, can also be challenging due to its smooth, textureless surface, which provides few features for the method to attach to. This approach would likely fail when the object undergoes extreme changes not captured by the initial mesh.

As a short conclusion, it can be said that the first four approaches are not useful for achieving the desired results mainly due to the extreme deformation of the objects. Therefore, all of the mentioned papers except the SpatialTracker are dismissed in our future work.

## Comparison of existing tracking methods

As the only option being left over is the SpatialTracker.This is the one we focus on in the next steps. In the paper of the SpatialTracker, the performance was compared with a few other tracking models. We decided to have a closer look on two of them because we considered them as relevant in the beginning. As for this, in the following paragraph, we focus on below listed models:

- Karaev et al., CoTracker: It is Better to Track Together ([Paper CoTracker](https://arxiv.org/pdf/2307.07635))
- Doersch et al., TAPIR: Tracking Any Point with per-frame Initialization and temporal Refinement ([Paper TAPIR](https://arxiv.org/pdf/2306.08637))
- Xiao et al., SpatialTracker: Tracking Any 2D Pixels in 3D Space ([Paper SpatialTracker](https://arxiv.org/pdf/2404.04319))

### TAPIR

TAPIR is a deep neural network model designed for the task of **Tracking Any Point** (TAP). Its main goal is to accurately follow a specific point of interest throughout a 2D video sequence, even if that point is on a deformable object, becomes occluded, or changes its appearance. It works in two steps: per-frame **initialization** and **iterative refinement**. The figure below shows the architecture of TAPIR.

<figure style="text-align: center;">
  <img src="tapir_architecture.png" alt="TAPIR architecture" style="width: 40%;">
  <figcaption>Figure: Tapir architecture</figcaption>
</figure>

The lower part of the figure shows the per-frame **per-frame initialization**. It focuses on finding potential matches for a given query point in each new frame of the video. This step is designed to be robust to the challenges of deformable object tracking. The key idea is to use a matching network (CNN) that compares the query point's features with the features of every other pixel in the target frame. This step outputs three initial values:

- initial guess for the trajectory (x, y)
- probability for occlusion
- uncertainty probability

In the second stage, the **iterative refinement**, which can be seen on the upper part of the figure, the above mentioned initial guesses are improved. For each potential position found during the initialization phase, the model defines a local neighborhood window around it. This window acts as a search area for refining the point's exact location. The refinement itself is achieved by comparing the visual features within this neighborhood to the features of the original query point. This comparison generates score maps indicate the similarity between the query point's features and every pixel within the neighborhood window. The highest-scoring pixel in this map represents the most probable refined position for the tracked point in that specific frame. This process is executed iteratively, allowing the model to correct small errors and ensure that the final trajectory is smooth and consistent over time.

### CoTracker

CoTracker is a paper that introduces another approach to point tracking in 2D videos. The core idea is that instead of tracking each point independently, it is more effective to track many points jointly, taking into account their dependencies and correlations. In the figure below the architecture is shown.

<figure style="text-align: center;">
  <img src="cotracker_architecture.png" alt="CoTracker architecture" style="width: 70%;">
  <figcaption>Figure: CoTracker architecture</figcaption>
</figure>

Unlike TAPIR that treats each point's trajectory as an independent problem, CoTracker uses a Transformer-based network to model the relationships and dependencies between multiple points simultaneously. The heart of this system is a powerful attention mechanism that enables the network to exchange information between different tracks and across various time steps within a given window of frames. This ability to collectively reason about the motion of multiple points makes CoTracker exceptionally robust. Furthermore, CoTracker is an online algorithm, meaning it can process video frames in real-time. To handle very long videos, it uses a sliding window approach. To achieve this, the model is trained in an unrolled fashion, like a recurrent neural network. The predictions from one window are used to initialize the tracks for the next overlapping window. This allows the model to maintain track consistency and accuracy over long durations.

The output of CoTracker is:

- Trajectory (x, y) over all frames
- occlusion probability

### SpatialTracker

SpatialTracker is a method that uses the CoTracker approach and extends its 2D point tracking to the 3D domain. As input data it uses either 2D videos (RGB) or videos with depth information (RGBD). The architecture can be found below.

<figure style="text-align: center;">
  <img src="spatracker_architecture.png" alt="SpatialTracker architecture" style="width: 70%;">
  <figcaption>Figure: SpatialTracker architecture</figcaption>
</figure>

SpatialTracker begins by estimating a depth map for each video frame and extracting dense image features, which are used to lift 2D pixels into 3D space to form a point cloud, see (a). As the monocular depth estimator (MDE) [ZoeDepth](https://arxiv.org/pdf/2302.12288) is used. These 3D points are then projected onto three orthogonal planes to create a compact triplane feature representation that enables efficient feature retrieval (b). An iterative transformer network refines the 3D trajectories of query points across short temporal windows, using extracted features from the triplanes as input (c). As a last step, the model learns a rigidity embedding that groups pixels with similar rigid motion. An As-Rigid-As-Possible (ARAP) constraint is then applied. The ARAP constraint enforces that 3D distances between points with similar rigidity embeddings remain constant over time.

while a rigidity embedding combined with an As-Rigid-As-Possible (ARAP) constraint enforces locally consistent motion.

The output of SpatialTracker is:

- 3D trajectory (x, y, z)
- occlusion probability

## Adaption and implementation

müssen die nachteil der anderen Modelle noch genannt werden? bzw warum wir sie nicht weiter verfolgen?

As a result of the SpatialTracker providing the best tracking performance (as it can be seen in the videos in the appendix), we only focus on the SpatialTracker in follow-up work. The other models can considered in future research. This section gives an overview of the adaption we made to the already provided code base: [Github SpatialTracker](https://github.com/henry123-boy/SpaTracker).

### Sliding window approach (online version)

Arian?

### Other depth estimator (VideoDepthAnything)

Lukas?

### Segmentation (Segment anything)

Leonie?

## Data generation

To be able to evaluate our implementation in the next section, we need a data set. Therefore, we recorded approximately 50 videos with different features:

- Objects

  - Resistance band
  - Gymnastic ball
  - Soft ball
  - Sponge

- Video resolution

  - 1080p
  - 720p
  - 360p

- Video length
  - between 5 seconds and 30 seconds

### Ground truth

To obtain reliable ground truth depth information for evaluating the tracking performance, depth images were recorded using a Time-of-Flight (ToF) camera. In our case the Femto Bolt from Orbbec was used, see below.

<figure style="text-align: center;">
  <img src="femto_bolt.jpg" alt="Femto Bolt" style="width: 50%;">
  <figcaption>Figure: Femto Bolt depth camera</figcaption>
</figure>

As the ToF camera outputs only individual frames, both the color stream and the depth stream had to be synchronized and merged to obtain a temporally continuous RGB-D video. This preprocessing is done by a python script (`preprocessing.py`).
The camera uses an IR-sensor to generate the depth images which can be read out as a .raw file which is then converted in a NumPy array format (.npy) to ensure efficient loading and processing. Additionally, the frames of the video stream are concatenated to obtain a .mp4 video.

During experimentation, the `--rgbd` argument can be set when running the `demo_chunked.py`. It then feeds this pre-recorded depth information directly into the SpatialTracker, bypassing the monocular depth estimation module. This setup enables a direct comparison between the model’s predicted depth and the actual measured depth from the ToF camera, thereby providing a robust basis for assessing the accuracy and reliability of the tracker’s performance on deformable objects.
