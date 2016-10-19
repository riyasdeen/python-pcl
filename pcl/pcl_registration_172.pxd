﻿from libcpp cimport bool

# main
cimport pcl_defs as cpp
from boost_shared_ptr cimport shared_ptr

# base
from eigen cimport Matrix4f

# registration.h
# template <typename PointSource, typename PointTarget, typename Scalar = float>
# class Registration : public PCLBase<PointSource>
cdef extern from "pcl/registration/registration.h" namespace "pcl" nogil:
    cdef cppclass Registration[Source, Target]:
        Registration()
        cppclass Matrix4:
            float *data()
        void align(cpp.PointCloud[Source] &) except +
        Matrix4 getFinalTransformation() except +
        double getFitnessScore() except +
        bool hasConverged() except +
        void setInputSource(cpp.PointCloudPtr_t) except +
        void setInputTarget(cpp.PointCloudPtr_t) except +
        void setMaximumIterations(int) except +

#   public:
#       typedef Eigen::Matrix<Scalar, 4, 4> Matrix4;
#       // using PCLBase<PointSource>::initCompute;
#       using PCLBase<PointSource>::deinitCompute;
#       using PCLBase<PointSource>::input_;
#       using PCLBase<PointSource>::indices_;
#       typedef boost::shared_ptr< Registration<PointSource, PointTarget, Scalar> > Ptr;
#       typedef boost::shared_ptr< const Registration<PointSource, PointTarget, Scalar> > ConstPtr;
#       typedef typename pcl::registration::CorrespondenceRejector::Ptr CorrespondenceRejectorPtr;
#       typedef pcl::search::KdTree<PointTarget> KdTree;
#       typedef typename pcl::search::KdTree<PointTarget>::Ptr KdTreePtr;
#       typedef pcl::search::KdTree<PointSource> KdTreeReciprocal;
#       typedef typename KdTree::Ptr KdTreeReciprocalPtr;
#       typedef pcl::PointCloud<PointSource> PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#       typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#       typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#       typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#       typedef typename KdTree::PointRepresentationConstPtr PointRepresentationConstPtr;
#       typedef typename pcl::registration::TransformationEstimation<PointSource, PointTarget, Scalar> TransformationEstimation;
#       typedef typename TransformationEstimation::Ptr TransformationEstimationPtr;
#       typedef typename TransformationEstimation::ConstPtr TransformationEstimationConstPtr;
#       typedef typename pcl::registration::CorrespondenceEstimationBase<PointSource, PointTarget, Scalar> CorrespondenceEstimation;
#       typedef typename CorrespondenceEstimation::Ptr CorrespondenceEstimationPtr;
#       typedef typename CorrespondenceEstimation::ConstPtr CorrespondenceEstimationConstPtr;
# 
#       /** \brief Provide a pointer to the transformation estimation object.
#         * (e.g., SVD, point to plane etc.) 
#         * \param[in] te is the pointer to the corresponding transformation estimation object
#         * Code example:
#         * \code
#         * TransformationEstimationPointToPlaneLLS<PointXYZ, PointXYZ>::Ptr trans_lls (new TransformationEstimationPointToPlaneLLS<PointXYZ, PointXYZ>);
#         * icp.setTransformationEstimation (trans_lls);
#         * // or...
#         * TransformationEstimationSVD<PointXYZ, PointXYZ>::Ptr trans_svd (new TransformationEstimationSVD<PointXYZ, PointXYZ>);
#         * icp.setTransformationEstimation (trans_svd);
#         * \endcode
#         */
#       void setTransformationEstimation (const TransformationEstimationPtr &te) { transformation_estimation_ = te; }
# 
#       /** \brief Provide a pointer to the correspondence estimation object.
#         * (e.g., regular, reciprocal, normal shooting etc.) 
#         * \param[in] ce is the pointer to the corresponding correspondence estimation object
#         * Code example:
#         * \code
#         * CorrespondenceEstimation<PointXYZ, PointXYZ>::Ptr ce (new CorrespondenceEstimation<PointXYZ, PointXYZ>);
#         * ce->setInputSource (source);
#         * ce->setInputTarget (target);
#         * icp.setCorrespondenceEstimation (ce);
#         * // or...
#         * CorrespondenceEstimationNormalShooting<PointNormal, PointNormal, PointNormal>::Ptr cens (new CorrespondenceEstimationNormalShooting<PointNormal, PointNormal>);
#         * ce->setInputSource (source);
#         * ce->setInputTarget (target);
#         * ce->setSourceNormals (source);
#         * ce->setTargetNormals (target);
#         * icp.setCorrespondenceEstimation (cens);
#         * \endcode
#         */
#       void setCorrespondenceEstimation (const CorrespondenceEstimationPtr &ce) { correspondence_estimation_ = ce; }
#       /** \brief Provide a pointer to the input source 
#         * (e.g., the point cloud that we want to align to the target)
#         * \param[in] cloud the input point cloud source
#         */
#       PCL_DEPRECATED ("[pcl::registration::Registration::setInputCloud] setInputCloud is deprecated. Please use setInputSource instead.")
#       void setInputCloud (const PointCloudSourceConstPtr &cloud);
#       /** \brief Get a pointer to the input point cloud dataset target. */
#       PCL_DEPRECATED ("[pcl::registration::Registration::getInputCloud] getInputCloud is deprecated. Please use getInputSource instead.")
#       PointCloudSourceConstPtr const getInputCloud ();
#       /** \brief Provide a pointer to the input source 
#         * (e.g., the point cloud that we want to align to the target)
#         * \param[in] cloud the input point cloud source
#       virtual void setInputSource (const PointCloudSourceConstPtr &cloud)
#       /** \brief Get a pointer to the input point cloud dataset target. */
#       inline PointCloudSourceConstPtr const getInputSource ()
#       /** \brief Provide a pointer to the input target (e.g., the point cloud that we want to align the input source to)
#         * \param[in] cloud the input point cloud target
#         */
#       virtual inline void setInputTarget (const PointCloudTargetConstPtr &cloud); 
#       /** \brief Get a pointer to the input point cloud dataset target. */
#       inline PointCloudTargetConstPtr const getInputTarget ()
#       /** \brief Provide a pointer to the search object used to find correspondences in
#         * the target cloud.
#         * \param[in] tree a pointer to the spatial search object.
#         * \param[in] force_no_recompute If set to true, this tree will NEVER be 
#         * recomputed, regardless of calls to setInputTarget. Only use if you are 
#         * confident that the tree will be set correctly.
#         */
#       inline void
#       setSearchMethodTarget (const KdTreePtr &tree, 
#                              bool force_no_recompute = false) 
#       /** \brief Get a pointer to the search method used to find correspondences in the
#         * target cloud. */
#       inline KdTreePtr getSearchMethodTarget () const
#       /** \brief Provide a pointer to the search object used to find correspondences in
#         * the source cloud (usually used by reciprocal correspondence finding).
#         * \param[in] tree a pointer to the spatial search object.
#         * \param[in] force_no_recompute If set to true, this tree will NEVER be 
#         * recomputed, regardless of calls to setInputSource. Only use if you are 
#         * extremely confident that the tree will be set correctly.
#         */
#       inline void
#       setSearchMethodSource (const KdTreeReciprocalPtr &tree, 
#                              bool force_no_recompute = false) 
#       /** \brief Get a pointer to the search method used to find correspondences in the
#         * source cloud. */
#       inline KdTreeReciprocalPtr getSearchMethodSource () const
#       /** \brief Get the final transformation matrix estimated by the registration method. */
#       inline Matrix4 getFinalTransformation ()
#       /** \brief Get the last incremental transformation matrix estimated by the registration method. */
#       inline Matrix4 getLastIncrementalTransformation ()
#       /** \brief Set the maximum number of iterations the internal optimization should run for.
#         * \param[in] nr_iterations the maximum number of iterations the internal optimization should run for
#         */
#       inline void setMaximumIterations (int nr_iterations)
#       /** \brief Get the maximum number of iterations the internal optimization should run for, as set by the user. */
#       inline int getMaximumIterations ()
#       /** \brief Set the number of iterations RANSAC should run for.
#         * \param[in] ransac_iterations is the number of iterations RANSAC should run for
#         */
#       inline void setRANSACIterations (int ransac_iterations)
#       /** \brief Get the number of iterations RANSAC should run for, as set by the user. */
#       inline double getRANSACIterations ()
#       /** \brief Set the inlier distance threshold for the internal RANSAC outlier rejection loop.
#         * The method considers a point to be an inlier, if the distance between the target data index and the transformed 
#         * source index is smaller than the given inlier distance threshold. 
#         * The value is set by default to 0.05m.
#         * \param[in] inlier_threshold the inlier distance threshold for the internal RANSAC outlier rejection loop
#         */
#       inline void setRANSACOutlierRejectionThreshold (double inlier_threshold) { inlier_threshold_ = inlier_threshold; }
#       /** \brief Get the inlier distance threshold for the internal outlier rejection loop as set by the user. */
#       inline double getRANSACOutlierRejectionThreshold ()
#       /** \brief Set the maximum distance threshold between two correspondent points in source <-> target. If the 
#         * distance is larger than this threshold, the points will be ignored in the alignment process.
#         * \param[in] distance_threshold the maximum distance threshold between a point and its nearest neighbor 
#         * correspondent in order to be considered in the alignment process
#         */
#       inline void setMaxCorrespondenceDistance (double distance_threshold)
#       /** \brief Get the maximum distance threshold between two correspondent points in source <-> target. If the 
#         * distance is larger than this threshold, the points will be ignored in the alignment process.
#         */
#       inline double getMaxCorrespondenceDistance ()
#       /** \brief Set the transformation epsilon (maximum allowable difference between two consecutive 
#         * transformations) in order for an optimization to be considered as having converged to the final 
#         * solution.
#         * \param[in] epsilon the transformation epsilon in order for an optimization to be considered as having 
#         * converged to the final solution.
#         */
#       inline void setTransformationEpsilon (double epsilon)
#       /** \brief Get the transformation epsilon (maximum allowable difference between two consecutive 
#         * transformations) as set by the user.
#         */
#       inline double getTransformationEpsilon ()
#       /** \brief Set the maximum allowed Euclidean error between two consecutive steps in the ICP loop, before 
#         * the algorithm is considered to have converged. 
#         * The error is estimated as the sum of the differences between correspondences in an Euclidean sense, 
#         * divided by the number of correspondences.
#         * \param[in] epsilon the maximum allowed distance error before the algorithm will be considered to have
#         * converged
#         */
#       inline void setEuclideanFitnessEpsilon (double epsilon)
#       /** \brief Get the maximum allowed distance error before the algorithm will be considered to have converged,
#         * as set by the user. See \ref setEuclideanFitnessEpsilon
#         */
#       inline double getEuclideanFitnessEpsilon ()
#       /** \brief Provide a boost shared pointer to the PointRepresentation to be used when comparing points
#         * \param[in] point_representation the PointRepresentation to be used by the k-D tree
#         */
#       inline void setPointRepresentation (const PointRepresentationConstPtr &point_representation)
#       /** \brief Register the user callback function which will be called from registration thread
#        * in order to update point cloud obtained after each iteration
#        * \param[in] visualizerCallback reference of the user callback function
#        */
#       template<typename FunctionSignature> inline bool
#       registerVisualizationCallback (boost::function<FunctionSignature> &visualizerCallback)
# 
#       /** \brief Obtain the Euclidean fitness score (e.g., sum of squared distances from the source to the target)
#         * \param[in] max_range maximum allowable distance between a point and its correspondence in the target 
#         * (default: double::max)
#         */
#       inline double 
#       getFitnessScore (double max_range = std::numeric_limits<double>::max ());
# 
#       /** \brief Obtain the Euclidean fitness score (e.g., sum of squared distances from the source to the target)
#         * from two sets of correspondence distances (distances between source and target points)
#         * \param[in] distances_a the first set of distances between correspondences
#         * \param[in] distances_b the second set of distances between correspondences
#         */
#       inline double 
#       getFitnessScore (const std::vector<float> &distances_a, const std::vector<float> &distances_b);
# 
#       /** \brief Return the state of convergence after the last align run */
#       inline bool hasConverged ()
# 
#       /** \brief Call the registration algorithm which estimates the transformation and returns the transformed source 
#         * (input) as \a output.
#         * \param[out] output the resultant input transfomed point cloud dataset
#         */
#       inline void align (PointCloudSource &output);
# 
#       /** \brief Call the registration algorithm which estimates the transformation and returns the transformed source 
#         * (input) as \a output.
#         * \param[out] output the resultant input transfomed point cloud dataset
#         * \param[in] guess the initial gross estimation of the transformation
#         */
#       inline void align (PointCloudSource &output, const Matrix4& guess);
# 
#       /** \brief Abstract class get name method. */
#       inline const std::string& getClassName () const
#       /** \brief Internal computation initalization. */
#       bool initCompute ();
#       /** \brief Internal computation when reciprocal lookup is needed */
#       bool initComputeReciprocal ();
#       /** \brief Add a new correspondence rejector to the list
#         * \param[in] rejector the new correspondence rejector to concatenate
#       inline void addCorrespondenceRejector (const CorrespondenceRejectorPtr &rejector)
#       /** \brief Get the list of correspondence rejectors. */
#       inline std::vector<CorrespondenceRejectorPtr> getCorrespondenceRejectors ()
#       /** \brief Remove the i-th correspondence rejector in the list
#         * \param[in] i the position of the correspondence rejector in the list to remove
#       inline bool removeCorrespondenceRejector (unsigned int i)
#       /** \brief Clear the list of correspondence rejectors. */
#       inline void clearCorrespondenceRejectors ()
# 
#       protected:
#       /** \brief The registration method name. */
#       std::string reg_name_;
#       /** \brief A pointer to the spatial search object. */
#       KdTreePtr tree_;
#       /** \brief A pointer to the spatial search object of the source. */
#       KdTreeReciprocalPtr tree_reciprocal_;
#       /** \brief The number of iterations the internal optimization ran for (used internally). */
#       int nr_iterations_;
#       /** \brief The maximum number of iterations the internal optimization should run for.
#         * The default value is 10.
#         */
#       int max_iterations_;
#       /** \brief The number of iterations RANSAC should run for. */
#       int ransac_iterations_;
#       /** \brief The input point cloud dataset target. */
#       PointCloudTargetConstPtr target_;
#       /** \brief The final transformation matrix estimated by the registration method after N iterations. */
#       Matrix4 final_transformation_;
#       /** \brief The transformation matrix estimated by the registration method. */
#       Matrix4 transformation_;
#       /** \brief The previous transformation matrix estimated by the registration method (used internally). */
#       Matrix4 previous_transformation_;
#       /** \brief The maximum difference between two consecutive transformations in order to consider convergence 
#         * (user defined). 
#         */
#       double transformation_epsilon_;
#       /** \brief The maximum allowed Euclidean error between two consecutive steps in the ICP loop, before the 
#         * algorithm is considered to have converged. The error is estimated as the sum of the differences between 
#         * correspondences in an Euclidean sense, divided by the number of correspondences.
#         */
#       double euclidean_fitness_epsilon_;
#       /** \brief The maximum distance threshold between two correspondent points in source <-> target. If the 
#         * distance is larger than this threshold, the points will be ignored in the alignement process.
#         */
#       double corr_dist_threshold_;
#       /** \brief The inlier distance threshold for the internal RANSAC outlier rejection loop.
#         * The method considers a point to be an inlier, if the distance between the target data index and the transformed 
#         * source index is smaller than the given inlier distance threshold. The default value is 0.05. 
#         */
#       double inlier_threshold_;
#       /** \brief Holds internal convergence state, given user parameters. */
#       bool converged_;
#       /** \brief The minimum number of correspondences that the algorithm needs before attempting to estimate the 
#         * transformation. The default value is 3.
#         */
#       int min_number_correspondences_;
#       /** \brief The set of correspondences determined at this ICP step. */
#       CorrespondencesPtr correspondences_;
#       /** \brief A TransformationEstimation object, used to calculate the 4x4 rigid transformation. */
#       TransformationEstimationPtr transformation_estimation_;
#       /** \brief A CorrespondenceEstimation object, used to estimate correspondences between the source and the target cloud. */
#       CorrespondenceEstimationPtr correspondence_estimation_;
#       /** \brief The list of correspondence rejectors to use. */
#       std::vector<CorrespondenceRejectorPtr> correspondence_rejectors_;
#       /** \brief Variable that stores whether we have a new target cloud, meaning we need to pre-process it again.
#        * This way, we avoid rebuilding the kd-tree for the target cloud every time the determineCorrespondences () method
#        * is called. */
#       bool target_cloud_updated_;
#       /** \brief Variable that stores whether we have a new source cloud, meaning we need to pre-process it again.
#        * This way, we avoid rebuilding the reciprocal kd-tree for the source cloud every time the determineCorrespondences () method
#        * is called. */
#       bool source_cloud_updated_;
#       /** \brief A flag which, if set, means the tree operating on the target cloud 
#        * will never be recomputed*/
#       bool force_no_recompute_;
#       /** \brief A flag which, if set, means the tree operating on the source cloud 
#        * will never be recomputed*/
#       bool force_no_recompute_reciprocal_;
#       /** \brief Callback function to update intermediate source point cloud position during it's registration
#         * to the target point cloud.
#       boost::function<void(const pcl::PointCloud<PointSource> &cloud_src,
#                            const std::vector<int> &indices_src,
#                            const pcl::PointCloud<PointTarget> &cloud_tgt,
#                            const std::vector<int> &indices_tgt)> update_visualizer_;
#       /** \brief Search for the closest nearest neighbor of a given point.
#         * \param cloud the point cloud dataset to use for nearest neighbor search
#         * \param index the index of the query point
#         * \param indices the resultant vector of indices representing the k-nearest neighbors
#         * \param distances the resultant distances from the query point to the k-nearest neighbors
#       inline bool
#       searchForNeighbors (const PointCloudSource &cloud, int index, 
#                           std::vector<int> &indices, std::vector<float> &distances)
#       /** \brief Abstract transformation computation method with initial guess */
#       virtual void 
#       computeTransformation (PointCloudSource &output, const Matrix4& guess) = 0;
#     public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

# warp_point_rigid.h
# template <class PointSourceT, class PointTargetT>
# class WarpPointRigid
cdef extern from "pcl/registration/warp_point_rigid.h" namespace "pcl" nogil:
    cdef cppclass WarpPointRigid[Source, Target]:
        WarpPointRigid (int nr_dim)
        # public:
        # virtual void 
        # setParam (const Eigen::VectorXf& p) = 0;
        # void warpPoint (const PointSourceT& pnt_in, PointSourceT& pnt_out) const
        # int getDimension () const {return nr_dim_;}
        # const Eigen::Matrix4f& 
        # getTransform () const { return transform_matrix_; }
        # protected:
        # int nr_dim_;
        # Eigen::Matrix4f transform_matrix_;

###

# correspondence_rejection.h
# class CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_estimation_normal_shooting.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejector:
        CorrespondenceRejector()
#         /** \brief Provide a pointer to the vector of the input correspondences.
#           * \param[in] correspondences the const boost shared pointer to a correspondence vector
#           */
#         virtual inline void 
#         setInputCorrespondences (const CorrespondencesConstPtr &correspondences) 
# 
#         /** \brief Get a pointer to the vector of the input correspondences.
#           * \return correspondences the const boost shared pointer to a correspondence vector
#           */
#         inline CorrespondencesConstPtr getInputCorrespondences ()
# 
#         /** \brief Run correspondence rejection
#           * \param[out] correspondences Vector of correspondences that have not been rejected.
#           */
#         inline void getCorrespondences (pcl::Correspondences &correspondences)
# 
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * Pure virtual. Compared to \a getCorrespondences this function is
#           * stateless, i.e., input correspondences do not need to be provided beforehand,
#           * but are directly provided in the function call.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         virtual inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences) = 0;
# 
#         /** \brief Determine the indices of query points of
#           * correspondences that have been rejected, i.e., the difference
#           * between the input correspondences (set via \a setInputCorrespondences)
#           * and the given correspondence vector.
#           * \param[in] correspondences Vector of correspondences after rejection
#           * \param[out] indices Vector of query point indices of those correspondences
#           * that have been rejected.
#           */
#         inline void 
#         getRejectedQueryIndices (const pcl::Correspondences &correspondences, 
#                                  std::vector<int>& indices)
# 
#     /** @b DataContainerInterface provides a generic interface for computing correspondence scores between correspondent
#       * points in the input and target clouds
#       * \ingroup registration
#       */
#     class DataContainerInterface
#     {
#       public:
#         virtual ~DataContainerInterface () {}
#         virtual double getCorrespondenceScore (int index) = 0;
#         virtual double getCorrespondenceScore (const pcl::Correspondence &) = 0;
#     };
# 
#     /** @b DataContainer is a container for the input and target point clouds and implements the interface 
#       * to compute correspondence scores between correspondent points in the input and target clouds
#       * \ingroup registration
#       */
#     template <typename PointT, typename NormalT=pcl::PointNormal>
#       class DataContainer : public DataContainerInterface
#     {
#       typedef typename pcl::PointCloud<PointT>::ConstPtr PointCloudConstPtr;
#       typedef typename pcl::KdTree<PointT>::Ptr KdTreePtr;
#       typedef typename pcl::PointCloud<NormalT>::ConstPtr NormalsPtr;
# 
#       public:
# 
#       /** \brief Empty constructor. */
#       DataContainer ()
# 
#       /** \brief Provide a source point cloud dataset (must contain XYZ
#        * data!), used to compute the correspondence distance.  
#        * \param[in] cloud a cloud containing XYZ data
#        */
#       inline void setInputCloud (const PointCloudConstPtr &cloud)
# 
#       /** \brief Provide a target point cloud dataset (must contain XYZ
#        * data!), used to compute the correspondence distance.  
#        * \param[in] target a cloud containing XYZ data
#        */
#       inline void setInputTarget (const PointCloudConstPtr &target)
# 
#       /** \brief Set the normals computed on the input point cloud
#         * \param[in] normals the normals computed for the input cloud
#         */
#       inline void setInputNormals (const NormalsPtr &normals)
# 
#       /** \brief Set the normals computed on the target point cloud
#         * \param[in] normals the normals computed for the input cloud
#         */
#       inline void setTargetNormals (const NormalsPtr &normals)
#       
#       /** \brief Get the normals computed on the input point cloud */
#       inline NormalsPtr getInputNormals ()
# 
#       /** \brief Get the normals computed on the target point cloud */
#       inline NormalsPtr getTargetNormals ()
# 
#       /** \brief Get the correspondence score for a point in the input cloud
#        *  \param[index] index of the point in the input cloud
#        */
#       inline double 
#         getCorrespondenceScore (int index)
# 
#       /** \brief Get the correspondence score for a given pair of correspondent points
#        *  \param[corr] Correspondent points
#        */
#       inline double 
#         getCorrespondenceScore (const pcl::Correspondence &corr)
#       
#       /** \brief Get the correspondence score for a given pair of correspondent points based on 
#         * the angle betweeen the normals. The normmals for the in put and target clouds must be 
#         * set before using this function
#         * \param[in] corr Correspondent points
#         */
#       double
#       getCorrespondenceScoreFromNormals (const pcl::Correspondence &corr)
###

# Inheritance

# icp.h
# template <typename PointSource, typename PointTarget>
# class IterativeClosestPoint : public Registration<PointSource, PointTarget>
cdef extern from "pcl/registration/icp.h" namespace "pcl" nogil:
    cdef cppclass IterativeClosestPoint[Source, Target](Registration[Source, Target]):
        IterativeClosestPoint() except +
        # ctypedef typename Registration<PointSource, PointTarget>::PointCloudSource PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef typename Registration<PointSource, PointTarget>::PointCloudTarget PointCloudTarget;
        # ctypedef PointIndices::Ptr PointIndicesPtr;
        # ctypedef PointIndices::ConstPtr PointIndicesConstPtr;
###

# gicp.h
cdef extern from "pcl/registration/gicp.h" namespace "pcl" nogil:
    cdef cppclass GeneralizedIterativeClosestPoint[Source, Target](Registration[Source, Target]):
        GeneralizedIterativeClosestPoint() except +
#     using IterativeClosestPoint<PointSource, PointTarget>::reg_name_;
#     using IterativeClosestPoint<PointSource, PointTarget>::getClassName;
#     using IterativeClosestPoint<PointSource, PointTarget>::indices_;
#     using IterativeClosestPoint<PointSource, PointTarget>::target_;
#     using IterativeClosestPoint<PointSource, PointTarget>::input_;
#     using IterativeClosestPoint<PointSource, PointTarget>::tree_;
#     using IterativeClosestPoint<PointSource, PointTarget>::nr_iterations_;
#     using IterativeClosestPoint<PointSource, PointTarget>::max_iterations_;
#     using IterativeClosestPoint<PointSource, PointTarget>::previous_transformation_;
#     using IterativeClosestPoint<PointSource, PointTarget>::final_transformation_;
#     using IterativeClosestPoint<PointSource, PointTarget>::transformation_;
#     using IterativeClosestPoint<PointSource, PointTarget>::transformation_epsilon_;
#     using IterativeClosestPoint<PointSource, PointTarget>::converged_;
#     using IterativeClosestPoint<PointSource, PointTarget>::corr_dist_threshold_;
#     using IterativeClosestPoint<PointSource, PointTarget>::inlier_threshold_;
#     using IterativeClosestPoint<PointSource, PointTarget>::min_number_correspondences_;
#     using IterativeClosestPoint<PointSource, PointTarget>::update_visualizer_;
#     typedef pcl::PointCloud<PointSource> PointCloudSource;
#     typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#     typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#     typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#     typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#     typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#     typedef PointIndices::Ptr PointIndicesPtr;
#     typedef PointIndices::ConstPtr PointIndicesConstPtr;
#     typedef typename pcl::KdTree<PointSource> InputKdTree;
#     typedef typename pcl::KdTree<PointSource>::Ptr InputKdTreePtr;
#     typedef Eigen::Matrix<double, 6, 1> Vector6d;
#     public:
#       /** \brief Provide a pointer to the input dataset
#         * \param cloud the const boost shared pointer to a PointCloud message
#         */
#       void setInputCloud (cpp.PointCloudPtr_t ptcloud)
# 
#       /** \brief Provide a pointer to the input target (e.g., the point cloud that we want to align the input source to)
#         * \param[in] target the input point cloud target
#         */
#       inline void setInputTarget (const PointCloudTargetConstPtr &target)
# 
#       /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using an iterative
#         * non-linear Levenberg-Marquardt approach.
#         * \param[in] cloud_src the source point cloud dataset
#         * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#         * \param[in] cloud_tgt the target point cloud dataset
#         * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
#         * \param[out] transformation_matrix the resultant transformation matrix
#         */
#       void estimateRigidTransformationBFGS (
#                                        const PointCloudSource &cloud_src,
#                                        const std::vector<int> &indices_src,
#                                        const PointCloudTarget &cloud_tgt,
#                                        const std::vector<int> &indices_tgt,
#                                        Eigen::Matrix4f &transformation_matrix);
#       
#       /** \brief \return Mahalanobis distance matrix for the given point index */
#       inline const Eigen::Matrix3d& mahalanobis(size_t index) const
# 
#       /** \brief Computes rotation matrix derivative.
#         * rotation matrix is obtainded from rotation angles x[3], x[4] and x[5]
#         * \return d/d_rx, d/d_ry and d/d_rz respectively in g[3], g[4] and g[5]
#         * param x array representing 3D transformation
#         * param R rotation matrix
#         * param g gradient vector
#         */
#       void computeRDerivative(const Vector6d &x, const Eigen::Matrix3d &R, Vector6d &g) const;
# 
#       /** \brief Set the rotation epsilon (maximum allowable difference between two 
#         * consecutive rotations) in order for an optimization to be considered as having 
#         * converged to the final solution.
#         * \param epsilon the rotation epsilon
#         */
#       inline void setRotationEpsilon (double epsilon)
# 
#       /** \brief Get the rotation epsilon (maximum allowable difference between two 
#         * consecutive rotations) as set by the user.
#         */
#       inline double getRotationEpsilon ()
# 
#       /** \brief Set the number of neighbors used when selecting a point neighbourhood
#         * to compute covariances. 
#         * A higher value will bring more accurate covariance matrix but will make 
#         * covariances computation slower.
#         * \param k the number of neighbors to use when computing covariances
#         */
#       void setCorrespondenceRandomness (int k)
# 
#       /** \brief Get the number of neighbors used when computing covariances as set by 
#         * the user 
#         */
#       int getCorrespondenceRandomness ()
# 
#       /** set maximum number of iterations at the optimization step
#         * \param[in] max maximum number of iterations for the optimizer
#         */
#       void setMaximumOptimizerIterations (int max)
# 
#       ///\return maximum number of iterations at the optimization step
#       int getMaximumOptimizerIterations ()
###

# icp_nl.h
# template <typename PointSource, typename PointTarget>
# class IterativeClosestPointNonLinear : public IterativeClosestPoint<PointSource, PointTarget>
#   cdef cppclass IterativeClosestPointNonLinear[Source, Target](Registration[Source, Target]):
cdef extern from "pcl/registration/icp_nl.h" namespace "pcl" nogil:
    cdef cppclass IterativeClosestPointNonLinear[Source, Target](IterativeClosestPoint[Source, Target]):
        IterativeClosestPointNonLinear() except +
###

###
# bfgs.h
# template< typename _Scalar >
# class PolynomialSolver<_Scalar,2> : public PolynomialSolverBase<_Scalar,2>
# cdef extern from "pcl/registration/bfgs.h" namespace "Eigen" nogil:
#     cdef cppclass PolynomialSolver[_Scalar, 2](PolynomialSolverBase[_Scalar, 2]):
#         PolynomialSolver (int nr_dim)
#     	  public:
#         typedef PolynomialSolverBase<_Scalar,2>    PS_Base;
#         EIGEN_POLYNOMIAL_SOLVER_BASE_INHERITED_TYPES( PS_Base )
#     	  public:
#         template< typename OtherPolynomial >
#         inline PolynomialSolver( const OtherPolynomial& poly, bool& hasRealRoot )
#         /** Computes the complex roots of a new polynomial. */
#         template< typename OtherPolynomial >
#         void compute( const OtherPolynomial& poly, bool& hasRealRoot)
#         template< typename OtherPolynomial > void compute( const OtherPolynomial& poly)
# 

# template<typename _Scalar, int NX=Eigen::Dynamic>
# struct BFGSDummyFunctor
# cdef extern from "pcl/registration/bfgs.h" nogil:
#     cdef struct BFGSDummyFunctor[_Scalar, NX]:
#         BFGSDummyFunctor ()
#         BFGSDummyFunctor(int inputs)
#     typedef _Scalar Scalar;
#     enum { InputsAtCompileTime = NX };
#     typedef Eigen::Matrix<Scalar,InputsAtCompileTime,1> VectorType;
#     const int m_inputs;
#     int inputs() const { return m_inputs; }
#     virtual double operator() (const VectorType &x) = 0;
#     virtual void  df(const VectorType &x, VectorType &df) = 0;
#     virtual void fdf(const VectorType &x, Scalar &f, VectorType &df) = 0;
# 
# namespace BFGSSpace {
#   enum Status {
#     NegativeGradientEpsilon = -3,
#     NotStarted = -2,
#     Running = -1,
#     Success = 0,
#     NoProgress = 1
#   };
# }
# 
# /**
#  * BFGS stands for Broyden窶擢letcher窶敵oldfarb窶鉄hanno (BFGS) method for solving 
#  * unconstrained nonlinear optimization problems. 
#  * For further details please visit: http://en.wikipedia.org/wiki/BFGS_method
#  * The method provided here is almost similar to the one provided by GSL.
#  * It reproduces Fletcher's original algorithm in Practical Methods of Optimization
#  * algorithms : 2.6.2 and 2.6.4 and uses the same politics in GSL with cubic 
#  * interpolation whenever it is possible else falls to quadratic interpolation for 
#  * alpha parameter.
#  */
# template<typename FunctorType>
# class BFGS
# cdef extern from "pcl/registration/bfgs.h" nogil:
#     cdef cppclass BFGS[FunctorType]:
#         # BFGS (FunctorType &_functor) 
# public:
#   typedef typename FunctorType::Scalar Scalar;
#   typedef typename FunctorType::VectorType FVectorType;
# 
#   typedef Eigen::DenseIndex Index;
# 
#   cdef struct Parameters
#     Parameters()
#     Index max_iters;   # maximum number of function evaluation
#     Index bracket_iters;
#     Index section_iters;
#     Scalar rho;
#     Scalar sigma;
#     Scalar tau1;
#     Scalar tau2;
#     Scalar tau3;
#     Scalar step_size;
#     Index order;
# 
#   BFGSSpace::Status minimize(FVectorType &x);
#   BFGSSpace::Status minimizeInit(FVectorType &x);
#   BFGSSpace::Status minimizeOneStep(FVectorType &x);
#   BFGSSpace::Status testGradient(Scalar epsilon);
#   void resetParameters(void) { parameters = Parameters(); }
#   
#   Parameters parameters;
#   Scalar f;
#   FVectorType gradient;
# 
#
# template<typename FunctorType> void
# BFGS<FunctorType>::checkExtremum(const Eigen::Matrix<Scalar, 4, 1>& coefficients, Scalar x, Scalar& xmin, Scalar& fmin)
# 
# template<typename FunctorType> void
# BFGS<FunctorType>::moveTo(Scalar alpha)
# 
# template<typename FunctorType> typename BFGS<FunctorType>::Scalar
# BFGS<FunctorType>::slope()
# 
# template<typename FunctorType> typename BFGS<FunctorType>::Scalar
# BFGS<FunctorType>::applyF(Scalar alpha)
# 
# template<typename FunctorType> typename BFGS<FunctorType>::Scalar
# BFGS<FunctorType>::applyDF(Scalar alpha)
# 
# template<typename FunctorType> void
# BFGS<FunctorType>::applyFDF(Scalar alpha, Scalar& f, Scalar& df)
# 
# template<typename FunctorType> void
# BFGS<FunctorType>::updatePosition (Scalar alpha, FVectorType &x, Scalar &f, FVectorType &g)
#
# template<typename FunctorType> void
# BFGS<FunctorType>::changeDirection ()
# 
# template<typename FunctorType> BFGSSpace::Status
# BFGS<FunctorType>::minimize(FVectorType  &x)
# 
# template<typename FunctorType> BFGSSpace::Status
# BFGS<FunctorType>::minimizeInit(FVectorType  &x)
# 
# template<typename FunctorType> BFGSSpace::Status
# BFGS<FunctorType>::minimizeOneStep(FVectorType  &x)
# 
# template<typename FunctorType> typename BFGSSpace::Status 
# BFGS<FunctorType>::testGradient(Scalar epsilon)
# 
# template<typename FunctorType> typename BFGS<FunctorType>::Scalar 
# BFGS<FunctorType>::interpolate (Scalar a, Scalar fa, Scalar fpa,
#                                 Scalar b, Scalar fb, Scalar fpb, 
#                                 Scalar xmin, Scalar xmax,
#                                 int order)
# 
# template<typename FunctorType> BFGSSpace::Status 
# BFGS<FunctorType>::lineSearch(Scalar rho, Scalar sigma, 
#                               Scalar tau1, Scalar tau2, Scalar tau3,
#                               int order, Scalar alpha1, Scalar &alpha_new)
###

# boost.h
# #include <boost/graph/adjacency_list.hpp>
# #include <boost/graph/graph_traits.hpp>
# #include <boost/graph/dijkstra_shortest_paths.hpp>
# #include <boost/property_map/property_map.hpp>
# #include <boost/unordered_map.hpp>
# #include <boost/noncopyable.hpp>
# #include <boost/make_shared.hpp>
# #include <boost/function.hpp>
# #include <boost/bind.hpp>
###

# boost_graph.h
# namespace boost
#     struct eigen_vecS
# 
#     template <class ValueType>
#     struct container_gen<eigen_vecS, ValueType>
#     {
#       typedef std::vector<ValueType, Eigen::aligned_allocator<ValueType> > type;
#     };
# 
#   template <>
#     struct parallel_edge_traits<eigen_vecS>
#     {
#       typedef allow_parallel_edge_tag type;
#     };
# 
#   namespace detail
#   {
#     template <>
#       struct is_random_access<eigen_vecS>
#       {
#         enum { value = true };
#         typedef mpl::true_ type;
#       };
#   }
# 
#   struct eigen_listS
#   {
#   };
# 
#   template <class ValueType>
#     struct container_gen<eigen_listS, ValueType>
#     {
#       typedef std::list<ValueType, Eigen::aligned_allocator<ValueType> > type;
#     };
# 
#   template <>
#     struct parallel_edge_traits<eigen_listS>
#     {
#       typedef allow_parallel_edge_tag type;
#     };
# 
#   namespace detail
#   {
#     template <>
#       struct is_random_access<eigen_listS>
#       {
#         enum { value = false };
#         typedef mpl::false_ type;
#       };
#   }
# }
###

# convergence_criteria.h
# namespace pcl
#   namespace registration
#     class PCL_EXPORTS ConvergenceCriteria
#     {
#       public:
#         typedef boost::shared_ptr<ConvergenceCriteria> Ptr;
#         typedef boost::shared_ptr<const ConvergenceCriteria> ConstPtr;
# 
#         /** \brief Empty constructor. */
#         ConvergenceCriteria () {}
# 
#         /** \brief Empty destructor. */
#         virtual ~ConvergenceCriteria () {}
# 
#         /** \brief Check if convergence has been reached. Pure virtual. */
#         virtual bool
#         hasConverged () = 0;
# 
#         /** \brief Bool operator. */
#         operator bool ()

# correspondence_estimation.h
# template <typename PointSource, typename PointTarget>
# class CorrespondenceEstimation : public PCLBase<PointSource>
cdef extern from "pcl/registration/correspondence_estimation.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceEstimation[Source, Target](cpp.PCLBase[Source]):
        CorrespondenceEstimation()
#       public:
#         using PCLBase<PointSource>::initCompute;
#         using PCLBase<PointSource>::deinitCompute;
#         using PCLBase<PointSource>::input_;
#         using PCLBase<PointSource>::indices_;
#         typedef typename pcl::KdTree<PointTarget> KdTree;
#         typedef typename pcl::KdTree<PointTarget>::Ptr KdTreePtr;
#         typedef pcl::PointCloud<PointSource> PointCloudSource;
#         typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#         typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#         typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#         typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#         typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#         typedef typename KdTree::PointRepresentationConstPtr PointRepresentationConstPtr;
#         /** \brief Provide a pointer to the input target (e.g., the point cloud that we want to align the 
#           * input source to)
#           * \param[in] cloud the input point cloud target
#         virtual inline void  setInputTarget (const PointCloudTargetConstPtr &cloud);
#         /** \brief Get a pointer to the input point cloud dataset target. */
#         inline PointCloudTargetConstPtr const getInputTarget () { return (target_ ); }
#         /** \brief Provide a boost shared pointer to the PointRepresentation to be used when comparing points
#           * \param[in] point_representation the PointRepresentation to be used by the k-D tree
#           */
#         inline void setPointRepresentation (const PointRepresentationConstPtr &point_representation)
#         /** \brief Determine the correspondences between input and target cloud.
#           * \param[out] correspondences the found correspondences (index of query point, index of target point, distance)
#           * \param[in] max_distance maximum distance between correspondences
#           */
#         virtual void 
#         determineCorrespondences (pcl::Correspondences &correspondences,
#                                   float max_distance = std::numeric_limits<float>::max ());
#         /** \brief Determine the correspondences between input and target cloud.
#           * \param[out] correspondences the found correspondences (index of query and target point, distance)
#           */
#         virtual void 
#         determineReciprocalCorrespondences (pcl::Correspondences &correspondences);
###

# correspondence_estimation_backprojection.h
# namespace pcl
# namespace registration
# /** \brief @b CorrespondenceEstimationBackprojection computes
#   * correspondences as points in the target cloud which have minimum
#   * \author Suat Gedikli
#   * \ingroup registration
#   */
# template <typename PointSource, typename PointTarget, typename NormalT, typename Scalar = float>
# class CorrespondenceEstimationBackProjection : public CorrespondenceEstimationBase <PointSource, PointTarget, Scalar>
#         CorrespondenceEstimationBackProjection ()
#         public:
#         typedef boost::shared_ptr<CorrespondenceEstimationBackProjection<PointSource, PointTarget, NormalT, Scalar> > Ptr;
#         typedef boost::shared_ptr<const CorrespondenceEstimationBackProjection<PointSource, PointTarget, NormalT, Scalar> > ConstPtr;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::initCompute;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::initComputeReciprocal;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::input_transformed_;
#         using PCLBase<PointSource>::deinitCompute;
#         using PCLBase<PointSource>::input_;
#         using PCLBase<PointSource>::indices_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::getClassName;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::point_representation_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::target_indices_;
#         typedef typename pcl::search::KdTree<PointTarget> KdTree;
#         typedef typename pcl::search::KdTree<PointTarget>::Ptr KdTreePtr;
#         typedef pcl::PointCloud<PointSource> PointCloudSource;
#         typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#         typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#         typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#         typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#         typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#         typedef pcl::PointCloud<NormalT> PointCloudNormals;
#         typedef typename PointCloudNormals::Ptr NormalsPtr;
#         typedef typename PointCloudNormals::ConstPtr NormalsConstPtr;
#         /** \brief Set the normals computed on the source point cloud
#           * \param[in] normals the normals computed for the source cloud
#           */
#         inline void setSourceNormals (const NormalsConstPtr &normals) { source_normals_ = normals; }
#         /** \brief Get the normals of the source point cloud
#           */
#         inline NormalsConstPtr getSourceNormals () const { return (source_normals_); }
#         /** \brief Set the normals computed on the target point cloud
#           * \param[in] normals the normals computed for the target cloud
#           */
#         inline void setTargetNormals (const NormalsConstPtr &normals) { target_normals_ = normals; }
#         /** \brief Get the normals of the target point cloud
#           */
#         inline NormalsConstPtr getTargetNormals () const { return (target_normals_); }
#         /** \brief See if this rejector requires source normals */
#         bool requiresSourceNormals () const
#         /** \brief Blob method for setting the source normals */
#         void setSourceNormals (pcl::PCLPointCloud2::ConstPtr cloud2)
#         /** \brief See if this rejector requires target normals*/
#         bool requiresTargetNormals () const
#         /** \brief Method for setting the target normals */
#         void setTargetNormals (pcl::PCLPointCloud2::ConstPtr cloud2)
#         /** \brief Determine the correspondences between input and target cloud.
#           * \param[out] correspondences the found correspondences (index of query point, index of target point, distance)
#           * \param[in] max_distance maximum distance between the normal on the source point cloud and the corresponding point in the target
#           * point cloud
#           */
#         void 
#         determineCorrespondences (pcl::Correspondences &correspondences,
#                                   double max_distance = std::numeric_limits<double>::max ());
#         /** \brief Determine the reciprocal correspondences between input and target cloud.
#           * A correspondence is considered reciprocal if both Src_i has Tgt_i as a 
#           * correspondence, and Tgt_i has Src_i as one.
#           *
#           * \param[out] correspondences the found correspondences (index of query and target point, distance)
#           * \param[in] max_distance maximum allowed distance between correspondences
#           */
#         virtual void 
#         determineReciprocalCorrespondences (pcl::Correspondences &correspondences,
#                                             double max_distance = std::numeric_limits<double>::max ());
#         /** \brief Set the number of nearest neighbours to be considered in the target 
#           * point cloud. By default, we use k = 10 nearest neighbors.
#           *
#           * \param[in] k the number of nearest neighbours to be considered
#           */
#         inline void setKSearch (unsigned int k)
#         /** \brief Get the number of nearest neighbours considered in the target point 
#           * cloud for computing correspondences. By default we use k = 10 nearest 
#           * neighbors.
#           */
#         inline void getKSearch ()
#         /** \brief Clone and cast to CorrespondenceEstimationBase */
#         virtual boost::shared_ptr< CorrespondenceEstimationBase<PointSource, PointTarget, Scalar> > 
#         clone () const
#         protected:
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::corr_name_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::tree_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::tree_reciprocal_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::target_;
#         /** \brief Internal computation initalization. */
#         bool initCompute ();

###


# # correspondence_estimation_normal_shooting.h
# template <typename PointSource, typename PointTarget, typename NormalT>
# class CorrespondenceEstimationNormalShooting : public CorrespondenceEstimation <PointSource, PointTarget>
cdef extern from "pcl/registration/correspondence_estimation_normal_shooting.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceEstimationNormalShooting[Source, Target, NormalT](CorrespondenceEstimation[Source, Target]):
        CorrespondenceEstimationNormalShooting()
#       public:
#         using PCLBase<PointSource>::initCompute;
#         using PCLBase<PointSource>::deinitCompute;
#         using PCLBase<PointSource>::input_;
#         using PCLBase<PointSource>::indices_;
#         using CorrespondenceEstimation<PointSource, PointTarget>::getClassName;
#         typedef typename pcl::KdTree<PointTarget> KdTree;
#         typedef typename pcl::KdTree<PointTarget>::Ptr KdTreePtr;
#         typedef pcl::PointCloud<PointSource> PointCloudSource;
#         typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#         typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#         typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#         typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#         typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#         typedef typename KdTree::PointRepresentationConstPtr PointRepresentationConstPtr;
#         typedef typename pcl::PointCloud<NormalT>::Ptr NormalsPtr;
#
#         /** \brief Set the normals computed on the input point cloud
#           * \param[in] normals the normals computed for the input cloud
#           */
#         inline void setSourceNormals (const NormalsPtr &normals)
# 
#         /** \brief Get the normals of the input point cloud
#           */
#         inline NormalsPtr getSourceNormals () const
# 
#         /** \brief Determine the correspondences between input and target cloud.
#           * \param[out] correspondences the found correspondences (index of query point, index of target point, distance)
#           * \param[in] max_distance maximum distance between the normal on the source point cloud and the corresponding point in the target
#           * point cloud
#           */
#         void 
#         determineCorrespondences (pcl::Correspondences &correspondences,
#                                   float max_distance = std::numeric_limits<float>::max ());
# 
#         /** \brief Set the number of nearest neighbours to be considered in the target point cloud
#           * \param[in] k the number of nearest neighbours to be considered
#           */
#         inline void setKSearch (unsigned int k)
# 
#         /** \brief Get the number of nearest neighbours considered in the target point cloud for computing correspondence
#           */
#         inline void getKSearch ()
###

# correspondence_estimation_organized_projection.h
# template <typename PointSource, typename PointTarget, typename Scalar = float>
# class CorrespondenceEstimationOrganizedProjection : public CorrespondenceEstimationBase <PointSource, PointTarget, Scalar>
#
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::initCompute;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::input_transformed_;
#         using PCLBase<PointSource>::deinitCompute;
#         using PCLBase<PointSource>::input_;
#         using PCLBase<PointSource>::indices_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::getClassName;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::point_representation_;
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::target_cloud_updated_;
#         typedef pcl::PointCloud<PointSource> PointCloudSource;
#         typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#         typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#         typedef pcl::PointCloud<PointTarget> PointCloudTarget;
#         typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#         typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
#         typedef boost::shared_ptr< CorrespondenceEstimationOrganizedProjection<PointSource, PointTarget, Scalar> > Ptr;
#         typedef boost::shared_ptr< const CorrespondenceEstimationOrganizedProjection<PointSource, PointTarget, Scalar> > ConstPtr;
#         /** \brief Empty constructor that sets all the intrinsic calibration to the default Kinect values. */
#         CorrespondenceEstimationOrganizedProjection ()
#         /** \brief Sets the focal length parameters of the target camera.
#           * \param[in] fx the focal length in pixels along the x-axis of the image
#           * \param[in] fy the focal length in pixels along the y-axis of the image
#           */
#         inline void setFocalLengths (const float fx, const float fy)
#         /** \brief Reads back the focal length parameters of the target camera.
#           * \param[out] fx the focal length in pixels along the x-axis of the image
#           * \param[out] fy the focal length in pixels along the y-axis of the image
#           */
#         inline void getFocalLengths (float &fx, float &fy) const
#         /** \brief Sets the camera center parameters of the target camera.
#           * \param[in] cx the x-coordinate of the camera center
#           * \param[in] cy the y-coordinate of the camera center
#           */
#         inline void setCameraCenters (const float cx, const float cy)
#         /** \brief Reads back the camera center parameters of the target camera.
#           * \param[out] cx the x-coordinate of the camera center
#           * \param[out] cy the y-coordinate of the camera center
#           */
#         inline void getCameraCenters (float &cx, float &cy) const
#         /** \brief Sets the transformation from the source point cloud to the target point cloud.
#           * \note The target point cloud must be in its local camera coordinates, so use this transformation to correct
#           * for that.
#           * \param[in] src_to_tgt_transformation the transformation
#           */
#         inline void setSourceTransformation (const Eigen::Matrix4f &src_to_tgt_transformation)
#         /** \brief Reads back the transformation from the source point cloud to the target point cloud.
#           * \note The target point cloud must be in its local camera coordinates, so use this transformation to correct
#           * for that.
#           * \return the transformation
#           */
#         inline Eigen::Matrix4f getSourceTransformation () const
#         /** \brief Sets the depth threshold; after projecting the source points in the image space of the target camera,
#           * this threshold is applied on the depths of corresponding dexels to eliminate the ones that are too far from
#           * each other.
#           * \param[in] depth_threshold the depth threshold
#           */
#         inline void setDepthThreshold (const float depth_threshold)
#         /** \brief Reads back the depth threshold; after projecting the source points in the image space of the target
#           * camera, this threshold is applied on the depths of corresponding dexels to eliminate the ones that are too
#           * far from each other.
#           * \return the depth threshold
#           */
#         inline float getDepthThreshold ()
#         /** \brief Computes the correspondences, applying a maximum Euclidean distance threshold.
#           * \param correspondences
#           * \param[in] max_distance Euclidean distance threshold above which correspondences will be rejected
#           */
#         void determineCorrespondences (Correspondences &correspondences, double max_distance);
#         /** \brief Computes the correspondences, applying a maximum Euclidean distance threshold.
#           * \param correspondences
#           * \param[in] max_distance Euclidean distance threshold above which correspondences will be rejected
#           */
#         void determineReciprocalCorrespondences (Correspondences &correspondences, double max_distance);
#         
#         /** \brief Clone and cast to CorrespondenceEstimationBase */
#         virtual boost::shared_ptr< CorrespondenceEstimationBase<PointSource, PointTarget, Scalar> > 
#         clone () const
# 
#         protected:
#         using CorrespondenceEstimationBase<PointSource, PointTarget, Scalar>::target_;
#         bool initCompute ();
#         float fx_, fy_;
#         float cx_, cy_;
#         Eigen::Matrix4f src_to_tgt_transformation_;
#         float depth_threshold_;
#         Eigen::Matrix3f projection_matrix_;
###

# 
# correspondence_rejection_distance.h
# class CorrespondenceRejectorDistance: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_distance.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorDistance(CorrespondenceRejector):
        CorrespondenceRejectorDistance()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
#         /** \brief Set the maximum distance used for thresholding in correspondence rejection.
#           * \param[in] distance Distance to be used as maximum distance between correspondences. 
#           * Correspondences with larger distances are rejected.
#           * \note Internally, the distance will be stored squared.
#           */
#         virtual inline void setMaximumDistance (float distance)
#         /** \brief Get the maximum distance used for thresholding in correspondence rejection. */
#         inline float getMaximumDistance ()
#         /** \brief Provide a source point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputCloud (const typename pcl::PointCloud<PointT>::ConstPtr &cloud)
# 
#         /** \brief Provide a target point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] target a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputTarget (const typename pcl::PointCloud<PointT>::ConstPtr &target)
# 
###

# correspondence_rejection_features.h
# class CorrespondenceRejectorFeatures: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_distance.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorFeatures(CorrespondenceRejector):
        CorrespondenceRejectorFeatures()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#         /** \brief Provide a pointer to a cloud of feature descriptors associated with the source point cloud
#           * \param[in] source_feature a cloud of feature descriptors associated with the source point cloud
#           * \param[in] key a string that uniquely identifies the feature
#           */
#         template <typename FeatureT> inline void 
#         setSourceFeature (const typename pcl::PointCloud<FeatureT>::ConstPtr &source_feature, 
#                           const std::string &key);
# 
#         /** \brief Get a pointer to the source cloud's feature descriptors, specified by the given \a key
#           * \param[in] key a string that uniquely identifies the feature (must match the key provided by setSourceFeature)
#           */
#         template <typename FeatureT> inline typename pcl::PointCloud<FeatureT>::ConstPtr 
#         getSourceFeature (const std::string &key);
# 
#         /** \brief Provide a pointer to a cloud of feature descriptors associated with the target point cloud
#           * \param[in] target_feature a cloud of feature descriptors associated with the target point cloud
#           * \param[in] key a string that uniquely identifies the feature
#           */
#         template <typename FeatureT> inline void 
#         setTargetFeature (const typename pcl::PointCloud<FeatureT>::ConstPtr &target_feature, 
#                           const std::string &key);
# 
#         /** \brief Get a pointer to the source cloud's feature descriptors, specified by the given \a key
#           * \param[in] key a string that uniquely identifies the feature (must match the key provided by setTargetFeature)
#           */
#         template <typename FeatureT> inline typename pcl::PointCloud<FeatureT>::ConstPtr 
#         getTargetFeature (const std::string &key);
# 
#         /** \brief Set a hard distance threshold in the feature \a FeatureT space, between source and target
#           * features. Any feature correspondence that is above this threshold will be considered bad and will be
#           * filtered out.
#           * \param[in] thresh the distance threshold
#           * \param[in] key a string that uniquely identifies the feature
#           */
#         template <typename FeatureT> inline void 
#         setDistanceThreshold (double thresh, const std::string &key);
# 
#         /** \brief Test that all features are valid (i.e., does each key have a valid source cloud, target cloud, 
#           * and search method)
#           */
#         inline bool hasValidFeatures ();
# 
#         /** \brief Provide a boost shared pointer to a PointRepresentation to be used when comparing features
#           * \param[in] key a string that uniquely identifies the feature
#           * \param[in] fr the point feature representation to be used 
#           */
#         template <typename FeatureT> inline void
#         setFeatureRepresentation (const typename pcl::PointRepresentation<FeatureT>::ConstPtr &fr,
#                                   const std::string &key);
# 
#         protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void 
#         applyRejection (pcl::Correspondences &correspondences)
# 
#         class FeatureContainerInterface
#         {
#           public:
#             virtual bool isValid () = 0;
#             virtual double getCorrespondenceScore (int index) = 0;
#             virtual bool isCorrespondenceValid (int index) = 0;
#         };
# 
#         typedef boost::unordered_map<std::string, boost::shared_ptr<FeatureContainerInterface> > FeaturesMap;
# 
#         /** \brief An STL map containing features to use when performing the correspondence search.*/
#         FeaturesMap features_map_;
# 
#         /** \brief An inner class containing pointers to the source and target feature clouds 
#           * and the parameters needed to perform the correspondence search.  This class extends 
#           * FeatureContainerInterface, which contains abstract methods for any methods that do not depend on the 
#           * FeatureT --- these methods can thus be called from a pointer to FeatureContainerInterface without 
#           * casting to the derived class.
#           */
#         template <typename FeatureT>
#         class FeatureContainer : public pcl::registration::CorrespondenceRejectorFeatures::FeatureContainerInterface
#           public:
#             typedef typename pcl::PointCloud<FeatureT>::ConstPtr FeatureCloudConstPtr;
#             typedef boost::function<int (const pcl::PointCloud<FeatureT> &, int, std::vector<int> &, 
#                                           std::vector<float> &)> SearchMethod;
#             typedef typename pcl::PointRepresentation<FeatureT>::ConstPtr PointRepresentationConstPtr;
#             FeatureContainer () : thresh_(std::numeric_limits<double>::max ()), feature_representation_()
#             inline void setSourceFeature (const FeatureCloudConstPtr &source_features)
#             inline FeatureCloudConstPtr getSourceFeature ()
#             inline void setTargetFeature (const FeatureCloudConstPtr &target_features)
#             inline FeatureCloudConstPtr getTargetFeature ()
#             inline void setDistanceThreshold (double thresh)
# 
#             virtual inline bool isValid ()
# 
#             /** \brief Provide a boost shared pointer to a PointRepresentation to be used when comparing features
#               * \param[in] fr the point feature representation to be used
#               */
#             inline void setFeatureRepresentation (const PointRepresentationConstPtr &fr)
#             /** \brief Obtain a score between a pair of correspondences.
#               * \param[in] the index to check in the list of correspondences
#               * \return score the resultant computed score
#               */
#             virtual inline double getCorrespondenceScore (int index)
#             /** \brief Check whether the correspondence pair at the given index is valid
#               * by computing the score and testing it against the user given threshold 
#               * \param[in] the index to check in the list of correspondences
#               * \return true if the correspondence is good, false otherwise
#               */
#             virtual inline bool isCorrespondenceValid (int index)
###

# correspondence_rejection_median_distance.h
# class CorrespondenceRejectorMedianDistance: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_median_distance.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorMedianDistance(CorrespondenceRejector):
        CorrespondenceRejectorMedianDistance()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
#         /** \brief Get the median distance used for thresholding in correspondence rejection. */
#         inline double getMedianDistance () const
#         /** \brief Provide a source point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputCloud (const typename pcl::PointCloud<PointT>::ConstPtr &cloud)
#         /** \brief Provide a target point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] target a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputTarget (const typename pcl::PointCloud<PointT>::ConstPtr &target)
#         /** \brief Set the factor for correspondence rejection. Points with distance greater than median times factor
#          *  will be rejected
#          *  \param[in] factor value
#          */
#         inline void setMedianFactor (double factor)
#         /** \brief Get the factor used for thresholding in correspondence rejection. */
#         inline double getMedianFactor () const { return factor_; };
# 
###

# correspondence_rejection_one_to_one.h
# class CorrespondenceRejectorOneToOne: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_one_to_one.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorOneToOne(CorrespondenceRejector):
        CorrespondenceRejectorOneToOne()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#       protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void 
#         applyRejection (pcl::Correspondences &correspondences)
#         {
#           getRemainingCorrespondences (*input_correspondences_, correspondences);
#         }
#     };

# 
###

# correspondence_rejection_organized_boundary.h
# namespace pcl
# namespace registration
#     class PCL_EXPORTS CorrespondenceRejectionOrganizedBoundary : public CorrespondenceRejector
#     {
#     public:
#       /** @brief Empty constructor. */
#       CorrespondenceRejectionOrganizedBoundary ()
#         : boundary_nans_threshold_ (8)
#         , window_size_ (5)
#         , depth_step_threshold_ (0.025f)
#         , data_container_ ()
#       { }
# 
#       void
#       getRemainingCorrespondences (const pcl::Correspondences& original_correspondences,
#                                    pcl::Correspondences& remaining_correspondences);
#       inline void setNumberOfBoundaryNaNs (int val)
#       template <typename PointT> inline void
#       setInputSource (const typename pcl::PointCloud<PointT>::ConstPtr &cloud)
#       template <typename PointT> inline void
#       setInputTarget (const typename pcl::PointCloud<PointT>::ConstPtr &cloud)
#       /** \brief See if this rejector requires source points */
#       bool requiresSourcePoints () const
#       /** \brief Blob method for setting the source cloud */
#       void setSourcePoints (pcl::PCLPointCloud2::ConstPtr cloud2)
#       /** \brief See if this rejector requires a target cloud */
#       bool requiresTargetPoints () const
#       /** \brief Method for setting the target cloud */
#       void setTargetPoints (pcl::PCLPointCloud2::ConstPtr cloud2)
#       virtual bool updateSource (const Eigen::Matrix4d &)
#       protected:
#       /** \brief Apply the rejection algorithm.
#         * \param[out] correspondences the set of resultant correspondences.
#         */
#       inline void applyRejection (pcl::Correspondences &correspondences)
#       int boundary_nans_threshold_;
#       int window_size_;
#       float depth_step_threshold_;
#       typedef boost::shared_ptr<pcl::registration::DataContainerInterface> DataContainerPtr;
#       DataContainerPtr data_container_;
###

# correspondence_rejection_poly.h
# namespace pcl
# namespace registration
# template <typename SourceT, typename TargetT>
# class PCL_EXPORTS CorrespondenceRejectorPoly: public CorrespondenceRejector
#         CorrespondenceRejectorPoly ()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         typedef boost::shared_ptr<CorrespondenceRejectorPoly> Ptr;
#         typedef boost::shared_ptr<const CorrespondenceRejectorPoly> ConstPtr;
#         typedef pcl::PointCloud<SourceT> PointCloudSource;
#         typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#         typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
#         typedef pcl::PointCloud<TargetT> PointCloudTarget;
#         typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#         typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
# 
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#         /** \brief Provide a source point cloud dataset (must contain XYZ data!), used to compute the correspondence distance.
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         inline void setInputSource (const PointCloudSourceConstPtr &cloud)
#
#         /** \brief Provide a source point cloud dataset (must contain XYZ data!), used to compute the correspondence distance.
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         inline void setInputCloud (const PointCloudSourceConstPtr &cloud)
# 
#         /** \brief Provide a target point cloud dataset (must contain XYZ data!), used to compute the correspondence distance.
#           * \param[in] target a cloud containing XYZ data
#           */
#         inline void setInputTarget (const PointCloudTargetConstPtr &target)
#         
#         /** \brief See if this rejector requires source points */
#         bool requiresSourcePoints () const
# 
#         /** \brief Blob method for setting the source cloud */
#         void setSourcePoints (pcl::PCLPointCloud2::ConstPtr cloud2)
#
#         /** \brief See if this rejector requires a target cloud */
#         bool requiresTargetPoints () const
# 
#         /** \brief Method for setting the target cloud */
#         void setTargetPoints (pcl::PCLPointCloud2::ConstPtr cloud2)
#         
#         /** \brief Set the polygon cardinality
#           * \param cardinality polygon cardinality
#           */
#         inline void setCardinality (int cardinality)
#         
#         /** \brief Get the polygon cardinality
#           * \return polygon cardinality
#           */
#         inline int getCardinality ()
#         
#         /** \brief Set the similarity threshold in [0,1[ between edge lengths,
#           * where 1 is a perfect match
#           * \param similarity_threshold similarity threshold
#           */
#         inline void setSimilarityThreshold (float similarity_threshold)
#         
#         /** \brief Get the similarity threshold between edge lengths
#           * \return similarity threshold
#           */
#         inline float getSimilarityThreshold ()
#         
#         /** \brief Set the number of iterations
#           * \param iterations number of iterations
#           */
#         inline void setIterations (int iterations)
#         
#         /** \brief Get the number of iterations
#           * \return number of iterations
#           */
#         inline int getIterations ()
#         
#         /** \brief Polygonal rejection of a single polygon, indexed by a subset of correspondences
#           * \param corr all correspondences into \ref input_ and \ref target_
#           * \param idx sampled indices into \b correspondences, must have a size equal to \ref cardinality_
#           * \return true if all edge length ratios are larger than or equal to \ref similarity_threshold_
#           */
#         inline bool thresholdPolygon (const pcl::Correspondences& corr, const std::vector<int>& idx)
#         
#         /** \brief Polygonal rejection of a single polygon, indexed by two point index vectors
#           * \param source_indices indices of polygon points in \ref input_, must have a size equal to \ref cardinality_
#           * \param target_indices corresponding indices of polygon points in \ref target_, must have a size equal to \ref cardinality_
#           * \return true if all edge length ratios are larger than or equal to \ref similarity_threshold_
#           */
#         inline bool thresholdPolygon (const std::vector<int>& source_indices, const std::vector<int>& target_indices)
#         
#         protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void applyRejection (pcl::Correspondences &correspondences)
#         
#         /** \brief Get k unique random indices in range {0,...,n-1} (sampling without replacement)
#           * \note No check is made to ensure that k <= n.
#           * \param n upper index range, exclusive
#           * \param k number of unique indices to sample
#           * \return k unique random indices in range {0,...,n-1}
#           */
#         inline std::vector<int> getUniqueRandomIndices (int n, int k)
#         
#         /** \brief Squared Euclidean distance between two points using the members x, y and z
#           * \param p1 first point
#           * \param p2 second point
#           * \return squared Euclidean distance
#           */
#         inline float computeSquaredDistance (const SourceT& p1, const TargetT& p2)
#         
#         /** \brief Edge length similarity thresholding
#           * \param index_query_1 index of first source vertex
#           * \param index_query_2 index of second source vertex
#           * \param index_match_1 index of first target vertex
#           * \param index_match_2 index of second target vertex
#           * \param simsq squared similarity threshold in [0,1]
#           * \return true if edge length ratio is larger than or equal to threshold
#           */
#         inline bool 
#         thresholdEdgeLength (int index_query_1,
#                              int index_query_2,
#                              int index_match_1,
#                              int index_match_2,
#                              float simsq)
#         
#         /** \brief Compute a linear histogram. This function is equivalent to the MATLAB function \b histc, with the
#           * edges set as follows: <b> lower:(upper-lower)/bins:upper </b>
#           * \param data input samples
#           * \param lower lower bound of input samples
#           * \param upper upper bound of input samples
#           * \param bins number of bins in output
#           * \return linear histogram
#           */
#         std::vector<int> 
#         computeHistogram (const std::vector<float>& data, float lower, float upper, int bins);
#         
#         /** \brief Find the optimal value for binary histogram thresholding using Otsu's method
#           * \param histogram input histogram
#           * \return threshold value according to Otsu's criterion
#           */
#         int findThresholdOtsu (const std::vector<int>& histogram);
# 
#         /** \brief The input point cloud dataset */
#         PointCloudSourceConstPtr input_;
#         /** \brief The input point cloud dataset target */
#         PointCloudTargetConstPtr target_;
#         /** \brief Number of iterations to run */
#         int iterations_;
#         /** \brief The polygon cardinality used during rejection */
#         int cardinality_;
#         /** \brief Lower edge length threshold in [0,1] used for verifying polygon similarities, where 1 is a perfect match */
#         float similarity_threshold_;
#         /** \brief Squared value if \ref similarity_threshold_, only for internal use */
#         float similarity_threshold_squared_;
###

# correspondence_rejection_sample_consensus.h
# template <typename PointT>
# class CorrespondenceRejectorSampleConsensus: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_sample_consensus.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorSampleConsensus[T](CorrespondenceRejector):
        CorrespondenceRejectorSampleConsensus()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#         /** \brief Provide a source point cloud dataset (must contain XYZ data!)
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         virtual inline void 
#         setInputCloud (const PointCloudConstPtr &cloud) { input_ = cloud; }
# 
#         /** \brief Provide a target point cloud dataset (must contain XYZ data!)
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         virtual inline void 
#         setTargetCloud (const PointCloudConstPtr &cloud) { target_ = cloud; }
# 
#         /** \brief Set the maximum distance between corresponding points.
#           * Correspondences with distances below the threshold are considered as inliers.
#           * \param[in] threshold Distance threshold in the same dimension as source and target data sets.
#           */
#         inline void 
#         setInlierThreshold (double threshold) { inlier_threshold_ = threshold; };
# 
#         /** \brief Get the maximum distance between corresponding points.
#           * \return Distance threshold in the same dimension as source and target data sets.
#           */
#         inline double 
#         getInlierThreshold() { return inlier_threshold_; };
# 
#         /** \brief Set the maximum number of iterations.
#           * \param[in] max_iterations Maximum number if iterations to run
#           */
#         inline void 
#         setMaxIterations (int max_iterations) {max_iterations_ = std::max(max_iterations, 0); };
# 
#         /** \brief Get the maximum number of iterations.
#           * \return max_iterations Maximum number if iterations to run
#           */
#         inline int 
#         getMaxIterations () { return max_iterations_; };
# 
#         /** \brief Get the best transformation after RANSAC rejection.
#           * \return The homogeneous 4x4 transformation yielding the largest number of inliers.
#           */
#         inline Eigen::Matrix4f 
#         getBestTransformation () { return best_transformation_; };
# 
#       protected:
# 
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void 
#         applyRejection (pcl::Correspondences &correspondences)
#         PointCloudConstPtr input_;
#         PointCloudConstPtr target_;
#         Eigen::Matrix4f best_transformation_;
#       public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

# correspondence_rejection_sample_consensus_2d.h
# namespace pcl
# namespace registration
# template <typename PointT>
# class CorrespondenceRejectorSampleConsensus2D: public CorrespondenceRejectorSampleConsensus<PointT>
#     {
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       public:
#         using CorrespondenceRejectorSampleConsensus<PointT>::refine_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::input_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::target_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::input_correspondences_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::rejection_name_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::getClassName;
#         using CorrespondenceRejectorSampleConsensus<PointT>::inlier_threshold_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::max_iterations_;
#         using CorrespondenceRejectorSampleConsensus<PointT>::best_transformation_;
# 
#         typedef boost::shared_ptr<CorrespondenceRejectorSampleConsensus2D> Ptr;
#         typedef boost::shared_ptr<const CorrespondenceRejectorSampleConsensus2D> ConstPtr;
# 
#         /** \brief Empty constructor. Sets the inlier threshold to 5cm (0.05m), 
#           * and the maximum number of iterations to 1000. 
#           */
#         CorrespondenceRejectorSampleConsensus2D ()
#           : projection_matrix_ (Eigen::Matrix3f::Identity ())
#         {
#           rejection_name_ = "CorrespondenceRejectorSampleConsensus2D";
#           // Put the projection matrix together
#           //projection_matrix_ (0, 0) = 525.f;
#           //projection_matrix_ (1, 1) = 525.f;
#           //projection_matrix_ (0, 2) = 320.f;
#           //projection_matrix_ (1, 2) = 240.f;
#         }
# 
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
#         /** \brief Sets the focal length parameters of the target camera.
#           * \param[in] fx the focal length in pixels along the x-axis of the image
#           * \param[in] fy the focal length in pixels along the y-axis of the image
#           */
#         inline void setFocalLengths (const float fx, const float fy)
#         /** \brief Reads back the focal length parameters of the target camera.
#           * \param[out] fx the focal length in pixels along the x-axis of the image
#           * \param[out] fy the focal length in pixels along the y-axis of the image
#           */
#         inline void getFocalLengths (float &fx, float &fy) const
#         /** \brief Sets the camera center parameters of the target camera.
#           * \param[in] cx the x-coordinate of the camera center
#           * \param[in] cy the y-coordinate of the camera center
#           */
#         inline void setCameraCenters (const float cx, const float cy)
#         /** \brief Reads back the camera center parameters of the target camera.
#           * \param[out] cx the x-coordinate of the camera center
#           * \param[out] cy the y-coordinate of the camera center
#           */
#         inline void getCameraCenters (float &cx, float &cy) const
#         protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void applyRejection (pcl::Correspondences &correspondences)
#         /** \brief Camera projection matrix. */
#         Eigen::Matrix3f projection_matrix_;
#         public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW

###

# correspondence_rejection_surface_normal.h
# class CorrespondenceRejectorSurfaceNormal : public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_surface_normal.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorSurfaceNormal(CorrespondenceRejector):
        CorrespondenceRejectorSurfaceNormal()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#         /** \brief Set the thresholding angle between the normals for correspondence rejection. 
#           * \param[in] threshold cosine of the thresholding angle between the normals for rejection
#           */
#         inline void
#         setThreshold (double threshold) { threshold_ = threshold; };
# 
#         /** \brief Get the thresholding angle between the normals for correspondence rejection. */
#         inline double
#         getThreshold () const { return threshold_; };
# 
#         /** \brief Initialize the data container object for the point type and the normal type
#           */
#         template <typename PointT, typename NormalT> inline void 
#         initializeDataContainer ()
#
#         /** \brief Provide a source point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputCloud (const typename pcl::PointCloud<PointT>::ConstPtr &input)
# 
#         /** \brief Provide a target point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] target a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputTarget (const typename pcl::PointCloud<PointT>::ConstPtr &target)
# 
#         /** \brief Set the normals computed on the input point cloud
#           * \param[in] normals the normals computed for the input cloud
#           */
#         template <typename PointT, typename NormalT> inline void 
#         setInputNormals (const typename pcl::PointCloud<NormalT>::ConstPtr &normals)
# 
#         /** \brief Set the normals computed on the target point cloud
#           * \param[in] normals the normals computed for the input cloud
#           */
#         template <typename PointT, typename NormalT> inline void 
#         setTargetNormals (const typename pcl::PointCloud<NormalT>::ConstPtr &normals)
# 
#         /** \brief Get the normals computed on the input point cloud */
#         template <typename NormalT> inline typename pcl::PointCloud<NormalT>::Ptr
#         getInputNormals () const { return boost::static_pointer_cast<DataContainer<pcl::PointXYZ, NormalT> > (data_container_)->getInputNormals (); }
# 
#         /** \brief Get the normals computed on the target point cloud */
#         template <typename NormalT> inline typename pcl::PointCloud<NormalT>::Ptr
#         getTargetNormals () const { return boost::static_pointer_cast<DataContainer<pcl::PointXYZ, NormalT> > (data_container_)->getTargetNormals (); }
# 
#         protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void applyRejection (pcl::Correspondences &correspondences)
#         /** \brief The median distance threshold between two correspondent points in source <-> target.
#           */
#         double threshold_;
#         typedef boost::shared_ptr<DataContainerInterface> DataContainerPtr;
#         /** \brief A pointer to the DataContainer object containing the input and target point clouds */
#         DataContainerPtr data_container_;
###

# correspondence_rejection_trimmed.h
#     class CorrespondenceRejectorTrimmed: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_trimmed.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorTrimmed(CorrespondenceRejector):
        CorrespondenceRejectorTrimmed()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Set the expected ratio of overlap between point clouds (in
#           * terms of correspondences).
#           * \param[in] ratio ratio of overlap between 0 (no overlap, no
#           * correspondences) and 1 (full overlap, all correspondences)
#           */
#         virtual inline void setOverlapRadio (float ratio)
# 
#         /** \brief Get the maximum distance used for thresholding in correspondence rejection. */
#         inline float getOverlapRadio ()
# 
#         /** \brief Set a minimum number of correspondences. If the specified overlap ratio causes to have
#           * less correspondences,  \a CorrespondenceRejectorTrimmed will try to return at least
#           * \a nr_min_correspondences_ correspondences (or all correspondences in case \a nr_min_correspondences_
#           * is less than the number of given correspondences). 
#           * \param[in] min_correspondences the minimum number of correspondences
#           */
#         inline void setMinCorrespondences (unsigned int min_correspondences) { nr_min_correspondences_ = min_correspondences; };
# 
#         /** \brief Get the minimum number of correspondences. */
#         inline unsigned int getMinCorrespondences ()
#
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences,
#                                      pcl::Correspondences& remaining_correspondences);
#       protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void 
#         applyRejection (pcl::Correspondences &correspondences)
#         {
#           getRemainingCorrespondences (*input_correspondences_, correspondences);
#         }
# 
#         /** Overlap Ratio in [0..1] */
#         float overlap_ratio_;
# 
#         /** Minimum number of correspondences. */
#         unsigned int nr_min_correspondences_;
###

# correspondence_rejection_var_trimmed.h
#     class CorrespondenceRejectorVarTrimmed: public CorrespondenceRejector
cdef extern from "pcl/registration/correspondence_rejection_var_trimmed.h" namespace "pcl::registration" nogil:
    cdef cppclass CorrespondenceRejectorVarTrimmed(CorrespondenceRejector):
        CorrespondenceRejectorVarTrimmed()
#       using CorrespondenceRejector::input_correspondences_;
#       using CorrespondenceRejector::rejection_name_;
#       using CorrespondenceRejector::getClassName;
#       public:
#         /** \brief Get a list of valid correspondences after rejection from the original set of correspondences.
#           * \param[in] original_correspondences the set of initial correspondences given
#           * \param[out] remaining_correspondences the resultant filtered set of remaining correspondences
#           */
#         inline void 
#         getRemainingCorrespondences (const pcl::Correspondences& original_correspondences, 
#                                      pcl::Correspondences& remaining_correspondences);
# 
#         /** \brief Get the trimmed distance used for thresholding in correspondence rejection. */
#         inline double
#         getTrimmedDistance () const { return trimmed_distance_; };
# 
#         /** \brief Provide a source point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] cloud a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputCloud (const typename pcl::PointCloud<PointT>::ConstPtr &cloud)
# 
#         /** \brief Provide a target point cloud dataset (must contain XYZ
#           * data!), used to compute the correspondence distance.  
#           * \param[in] target a cloud containing XYZ data
#           */
#         template <typename PointT> inline void 
#         setInputTarget (const typename pcl::PointCloud<PointT>::ConstPtr &target)
# 
#         /** \brief Get the computed inlier ratio used for thresholding in correspondence rejection. */
#         inline double
#         getTrimFactor () const { return factor_; }
# 
#         /** brief set the minimum overlap ratio
#           * \param[in] ratio the overlap ratio [0..1]
#           */
#         inline void
#         setMinRatio (double ratio) { min_ratio_ = ratio; }
# 
#         /** brief get the minimum overlap ratio
#           */
#         inline double
#         getMinRatio () const { return min_ratio_; }
# 
#         /** brief set the maximum overlap ratio
#           * \param[in] ratio the overlap ratio [0..1]
#           */
#         inline void
#         setMaxRatio (double ratio) { max_ratio_ = ratio; }
# 
#         /** brief get the maximum overlap ratio
#           */
#         inline double
#         getMaxRatio () const { return max_ratio_; }
#       protected:
#         /** \brief Apply the rejection algorithm.
#           * \param[out] correspondences the set of resultant correspondences.
#           */
#         inline void 
#         applyRejection (pcl::Correspondences &correspondences)
#         {
#           getRemainingCorrespondences (*input_correspondences_, correspondences);
#         }
# 
#         /** \brief The inlier distance threshold (based on the computed trim factor) between two correspondent points in source <-> target.
#           */
#         double trimmed_distance_;
# 
#         /** \brief The factor for correspondence rejection. Only factor times the total points sorted based on 
#          *  the correspondence distances will be considered as inliers. Remaining points are rejected. This factor is
#          *  computed internally 
#          */
#         double factor_;
# 
#         /** \brief The minimum overlap ratio between the input and target clouds
#          */
#         double min_ratio_;
# 
#         /** \brief The maximum overlap ratio between the input and target clouds
#          */
#         double max_ratio_;
# 
#                 /** \brief part of the term that balances the root mean square difference. This is an internal parameter
#          */
#         double lambda_;
# 
#         typedef boost::shared_ptr<DataContainerInterface> DataContainerPtr;
# 
#         /** \brief A pointer to the DataContainer object containing the input and target point clouds */
#         DataContainerPtr data_container_;
# 
###

# correspondence_sorting.h
#     /** @b sortCorrespondencesByQueryIndex : a functor for sorting correspondences by query index
#       * \author Dirk Holz
#       * \ingroup registration
#       */
#     struct sortCorrespondencesByQueryIndex : public std::binary_function<pcl::Correspondence, pcl::Correspondence, bool>
#     {
#       bool
#       operator()( pcl::Correspondence a, pcl::Correspondence b)
#       {
#         return (a.index_query < b.index_query);
#       }
#     };
# 
#     /** @b sortCorrespondencesByMatchIndex : a functor for sorting correspondences by match index
#       * \author Dirk Holz
#       * \ingroup registration
#       */
#     struct sortCorrespondencesByMatchIndex : public std::binary_function<pcl::Correspondence, pcl::Correspondence, bool>
#     {
#       bool 
#       operator()( pcl::Correspondence a, pcl::Correspondence b)
#       {
#         return (a.index_match < b.index_match);
#       }
#     };
# 
#     /** @b sortCorrespondencesByDistance : a functor for sorting correspondences by distance
#       * \author Dirk Holz
#       * \ingroup registration
#       */
#     struct sortCorrespondencesByDistance : public std::binary_function<pcl::Correspondence, pcl::Correspondence, bool>
#     {
#       bool 
#       operator()( pcl::Correspondence a, pcl::Correspondence b)
#       {
#         return (a.distance < b.distance);
#       }
#     };
# 
#     /** @b sortCorrespondencesByQueryIndexAndDistance : a functor for sorting correspondences by query index _and_ distance
#       * \author Dirk Holz
#       * \ingroup registration
#       */
#     struct sortCorrespondencesByQueryIndexAndDistance : public std::binary_function<pcl::Correspondence, pcl::Correspondence, bool>
#     {
#       inline bool 
#       operator()( pcl::Correspondence a, pcl::Correspondence b)
#       {
#         if (a.index_query < b.index_query)
#           return (true);
#         else if ( (a.index_query == b.index_query) && (a.distance < b.distance) )
#           return (true);
#         return (false);
#       }
#     };
# 
#     /** @b sortCorrespondencesByMatchIndexAndDistance : a functor for sorting correspondences by match index _and_ distance
#       * \author Dirk Holz
#       * \ingroup registration
#       */
#     struct sortCorrespondencesByMatchIndexAndDistance : public std::binary_function<pcl::Correspondence, pcl::Correspondence, bool>
#     {
#       inline bool 
#       operator()( pcl::Correspondence a, pcl::Correspondence b)
#       {
#         if (a.index_match < b.index_match)
#           return (true);
#         else if ( (a.index_match == b.index_match) && (a.distance < b.distance) )
#           return (true);
#         return (false);
#       }
#     };

# 
###

# correspondence_types.h
#     /** \brief calculates the mean and standard deviation of descriptor distances from correspondences
#       * \param[in] correspondences list of correspondences
#       * \param[out] mean the mean descriptor distance of correspondences
#       * \param[out] stddev the standard deviation of descriptor distances.
#       * \note The sample varaiance is used to determine the standard deviation
#       */
#     inline void 
#     getCorDistMeanStd (const pcl::Correspondences& correspondences, double &mean, double &stddev);
# 
#     /** \brief extracts the query indices
#       * \param[in] correspondences list of correspondences
#       * \param[out] indices array of extracted indices.
#       * \note order of indices corresponds to input list of descriptor correspondences
#       */
#     inline void 
#     getQueryIndices (const pcl::Correspondences& correspondences, std::vector<int>& indices);
# 
#     /** \brief extracts the match indices
#       * \param[in] correspondences list of correspondences
#       * \param[out] indices array of extracted indices.
#       * \note order of indices corresponds to input list of descriptor correspondences
#       */
#     inline void 
#     getMatchIndices (const pcl::Correspondences& correspondences, std::vector<int>& indices);

# 
###

# default_convergence_criteria.h
# namespace pcl
# {
#   namespace registration
#   {
#     /** \brief @b DefaultConvergenceCriteria represents an instantiation of
#       * ConvergenceCriteria, and implements the following criteria for registration loop
#       * evaluation:
#       *
#       *  * a maximum number of iterations has been reached
#       *  * the transformation (R, t) cannot be further updated (the difference between current and previous is smaller than a threshold)
#       *  * the Mean Squared Error (MSE) between the current set of correspondences and the previous one is smaller than some threshold (both relative and absolute tests)
#       *
#       * \note Convergence is considered reached if ANY of the above criteria are met.
#       *
#       * \author Radu B. Rusu
#       * \ingroup registration
#       */
#     template <typename Scalar = float>
#     class DefaultConvergenceCriteria : public ConvergenceCriteria
#     {
#       public:
#         typedef boost::shared_ptr<DefaultConvergenceCriteria<Scalar> > Ptr;
#         typedef boost::shared_ptr<const DefaultConvergenceCriteria<Scalar> > ConstPtr;
# 
#         typedef Eigen::Matrix<Scalar, 4, 4> Matrix4;
# 
#         enum ConvergenceState
#         {
#           CONVERGENCE_CRITERIA_NOT_CONVERGED,
#           CONVERGENCE_CRITERIA_ITERATIONS,
#           CONVERGENCE_CRITERIA_TRANSFORM,
#           CONVERGENCE_CRITERIA_ABS_MSE,
#           CONVERGENCE_CRITERIA_REL_MSE,
#           CONVERGENCE_CRITERIA_NO_CORRESPONDENCES
#         };
# 
#         /** \brief Empty constructor.
#           * Sets:
#           *  * the maximum number of iterations to 1000
#           *  * the rotation threshold to 0.256 degrees (0.99999)
#           *  * the translation threshold to 0.0003 meters (3e-4^2)
#           *  * the MSE relative / absolute thresholds to 0.001% and 1e-12
#           *
#           * \param[in] iterations a reference to the number of iterations the loop has ran so far
#           * \param[in] transform a reference to the current transformation obtained by the transformation evaluation
#           * \param[in] correspondences a reference to the current set of point correspondences between source and target
#           */
#         DefaultConvergenceCriteria (const int &iterations, const Matrix4 &transform, const pcl::Correspondences &correspondences)
#           : iterations_ (iterations)
#           , transformation_ (transform)
#           , correspondences_ (correspondences)
#           , correspondences_prev_mse_ (std::numeric_limits<double>::max ())
#           , correspondences_cur_mse_ (std::numeric_limits<double>::max ())
#           , max_iterations_ (100)                 // 100 iterations
#           , failure_after_max_iter_ (false)
#           , rotation_threshold_ (0.99999)         // 0.256 degrees
#           , translation_threshold_ (3e-4 * 3e-4)  // 0.0003 meters
#           , mse_threshold_relative_ (0.00001)     // 0.001% of the previous MSE (relative error)
#           , mse_threshold_absolute_ (1e-12)       // MSE (absolute error)
#           , iterations_similar_transforms_ (0)
#           , max_iterations_similar_transforms_ (0)
#           , convergence_state_ (CONVERGENCE_CRITERIA_NOT_CONVERGED)
#         {
#         }
#       
#         /** \brief Empty destructor */
#         virtual ~DefaultConvergenceCriteria () {}
# 
#         /** \brief Set the maximum number of iterations that the internal rotation, 
#           * translation, and MSE differences are allowed to be similar. 
#           * \param[in] nr_iterations the maximum number of iterations 
#           */
#         inline void
#         setMaximumIterationsSimilarTransforms (const int nr_iterations) { max_iterations_similar_transforms_ = nr_iterations; }
# 
#         /** \brief Get the maximum number of iterations that the internal rotation, 
#           * translation, and MSE differences are allowed to be similar, as set by the user.
#           */
#         inline int
#         getMaximumIterationsSimilarTransforms () const { return (max_iterations_similar_transforms_); }
# 
#         /** \brief Set the maximum number of iterations the internal optimization should run for.
#           * \param[in] nr_iterations the maximum number of iterations the internal optimization should run for
#           */
#         inline void
#         setMaximumIterations (const int nr_iterations) { max_iterations_ = nr_iterations; }
# 
#         /** \brief Get the maximum number of iterations the internal optimization should run for, as set by the user. */
#         inline int
#         getMaximumIterations () const { return (max_iterations_); }
# 
#         /** \brief Specifies if the registration fails or converges when the maximum number of iterations is reached.
#           * \param[in] failure_after_max_iter If true, the registration fails. If false, the registration is assumed to have converged.
#           */
#         inline void
#         setFailureAfterMaximumIterations (const bool failure_after_max_iter) { failure_after_max_iter_ = failure_after_max_iter; }
# 
#         /** \brief Get whether the registration will fail or converge when the maximum number of iterations is reached. */
#         inline bool
#         getFailureAfterMaximumIterations () const { return (failure_after_max_iter_); }
# 
#         /** \brief Set the rotation threshold cosine angle (maximum allowable difference between two consecutive transformations) in order for an optimization to be considered as having converged to the final solution.
#           * \param[in] threshold the rotation threshold in order for an optimization to be considered as having converged to the final solution.
#           */
#         inline void
#         setRotationThreshold (const double threshold) { rotation_threshold_ = threshold; }
# 
#         /** \brief Get the rotation threshold cosine angle (maximum allowable difference between two consecutive transformations) as set by the user.
#           */
#         inline double
#         getRotationThreshold () const { return (rotation_threshold_); }
# 
#         /** \brief Set the translation threshold (maximum allowable difference between two consecutive transformations) in order for an optimization to be considered as having converged to the final solution.
#           * \param[in] threshold the translation threshold in order for an optimization to be considered as having converged to the final solution.
#           */
#         inline void
#         setTranslationThreshold (const double threshold) { translation_threshold_ = threshold; }
# 
#         /** \brief Get the rotation threshold cosine angle (maximum allowable difference between two consecutive transformations) as set by the user.
#           */
#         inline double
#         getTranslationThreshold () const { return (translation_threshold_); }
# 
#         /** \brief Set the relative MSE between two consecutive sets of correspondences.
#           * \param[in] mse_relative the relative MSE threshold
#           */
#         inline void
#         setRelativeMSE (const double mse_relative) { mse_threshold_relative_ = mse_relative; }
# 
#         /** \brief Get the relative MSE between two consecutive sets of correspondences. */
#         inline double
#         getRelativeMSE () const { return (mse_threshold_relative_); }
# 
#         /** \brief Set the absolute MSE between two consecutive sets of correspondences.
#           * \param[in] mse_absolute the relative MSE threshold
#           */
#         inline void
#         setAbsoluteMSE (const double mse_absolute) { mse_threshold_absolute_ = mse_absolute; }
# 
#         /** \brief Get the absolute MSE between two consecutive sets of correspondences. */
#         inline double
#         getAbsoluteMSE () const { return (mse_threshold_absolute_); }
# 
# 
#         /** \brief Check if convergence has been reached. */
#         virtual bool
#         hasConverged ();
# 
#         /** \brief Return the convergence state after hasConverged () */
#         ConvergenceState
#         getConvergenceState ()
#         {
#           return (convergence_state_);
#         }
# 
#         /** \brief Sets the convergence state externally (for example, when ICP does not find
#          * enough correspondences to estimate a transformation, the function is called setting
#          * the convergence state to ConvergenceState::CONVERGENCE_CRITERIA_NO_CORRESPONDENCES)
#          * \param[in] c the convergence state
#          */
#         inline void
#         setConvergenceState(ConvergenceState c)
#         {
#           convergence_state_ = c;
#         }
# 
#       protected:
# 
#         /** \brief Calculate the mean squared error (MSE) of the distance for a given set of correspondences.
#           * \param[in] correspondences the given set of correspondences
#           */
#         inline double
#         calculateMSE (const pcl::Correspondences &correspondences) const
#         {
#           double mse = 0;
#           for (size_t i = 0; i < correspondences.size (); ++i)
#             mse += correspondences[i].distance;
#           mse /= double (correspondences.size ());
#           return (mse);
#         }
# 
#         /** \brief The number of iterations done by the registration loop so far. */
#         const int &iterations_;
# 
#         /** \brief The current transformation obtained by the transformation estimation method. */
#         const Matrix4 &transformation_;
# 
#         /** \brief The current set of point correspondences between the source and the target. */
#         const pcl::Correspondences &correspondences_;
# 
#         /** \brief The MSE for the previous set of correspondences. */
#         double correspondences_prev_mse_;
# 
#         /** \brief The MSE for the current set of correspondences. */
#         double correspondences_cur_mse_;
# 
#         /** \brief The maximum nuyyGmber of iterations that the registration loop is to be executed. */
#         int max_iterations_;
# 
#         /** \brief Specifys if the registration fails or converges when the maximum number of iterations is reached. */
#         bool failure_after_max_iter_;
# 
#         /** \brief The rotation threshold is the relative rotation between two iterations (as angle cosine). */
#         double rotation_threshold_;
# 
#         /** \brief The translation threshold is the relative translation between two iterations (0 if no translation). */
#         double translation_threshold_;
# 
#         /** \brief The relative change from the previous MSE for the current set of correspondences, e.g. .1 means 10% change. */
#         double mse_threshold_relative_;
# 
#         /** \brief The absolute change from the previous MSE for the current set of correspondences. */
#         double mse_threshold_absolute_;
# 
#         /** \brief Internal counter for the number of iterations that the internal 
#           * rotation, translation, and MSE differences are allowed to be similar. */
#         int iterations_similar_transforms_;
# 
#         /** \brief The maximum number of iterations that the internal rotation, 
#           * translation, and MSE differences are allowed to be similar. */
#         int max_iterations_similar_transforms_;
# 
#         /** \brief The state of the convergence (e.g., why did the registration converge). */
#         ConvergenceState convergence_state_;
# 
#       public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

# distances.h
#     /** \brief Compute the median value from a set of doubles
#       * \param[in] fvec the set of doubles
#       * \param[in] m the number of doubles in the set
#       */
#     inline double 
#     computeMedian (double *fvec, int m)
#     {
#       // Copy the values to vectors for faster sorting
#       std::vector<double> data (m);
#       memcpy (&data[0], fvec, sizeof (double) * m);
#       
#       std::nth_element(data.begin(), data.begin() + (data.size () >> 1), data.end());
#       return (data[data.size () >> 1]);
#     }
# 
#     /** \brief Use a Huber kernel to estimate the distance between two vectors
#       * \param[in] p_src the first eigen vector
#       * \param[in] p_tgt the second eigen vector
#       * \param[in] sigma the sigma value
#       */
#     inline double
#     huber (const Eigen::Vector4f &p_src, const Eigen::Vector4f &p_tgt, double sigma) 
#     {
#       Eigen::Array4f diff = (p_tgt.array () - p_src.array ()).abs ();
#       double norm = 0.0;
#       for (int i = 0; i < 3; ++i)
#       {
#         if (diff[i] < sigma)
#           norm += diff[i] * diff[i];
#         else
#           norm += 2.0 * sigma * diff[i] - sigma * sigma;
#       }
#       return (norm);
#     }
# 
#     /** \brief Use a Huber kernel to estimate the distance between two vectors
#       * \param[in] diff the norm difference between two vectors
#       * \param[in] sigma the sigma value
#       */
#     inline double
#     huber (double diff, double sigma) 
#     {
#       double norm = 0.0;
#       if (diff < sigma)
#         norm += diff * diff;
#       else
#         norm += 2.0 * sigma * diff - sigma * sigma;
#       return (norm);
#     }
# 
#     /** \brief Use a Gedikli kernel to estimate the distance between two vectors
#       * (for more information, see 
#       * \param[in] val the norm difference between two vectors
#       * \param[in] clipping the clipping value
#       * \param[in] slope the slope. Default: 4
#       */
#     inline double
#     gedikli (double val, double clipping, double slope = 4) 
#     {
#       return (1.0 / (1.0 + pow (fabs(val) / clipping, slope)));
#     }
# 
#     /** \brief Compute the Manhattan distance between two eigen vectors.
#       * \param[in] p_src the first eigen vector
#       * \param[in] p_tgt the second eigen vector
#       */
#     inline double
#     l1 (const Eigen::Vector4f &p_src, const Eigen::Vector4f &p_tgt) 
#     {
#       return ((p_src.array () - p_tgt.array ()).abs ().sum ());
#     }
# 
#     /** \brief Compute the Euclidean distance between two eigen vectors.
#       * \param[in] p_src the first eigen vector
#       * \param[in] p_tgt the second eigen vector
#       */
#     inline double
#     l2 (const Eigen::Vector4f &p_src, const Eigen::Vector4f &p_tgt) 
#     {
#       return ((p_src - p_tgt).norm ());
#     }
# 
#     /** \brief Compute the squared Euclidean distance between two eigen vectors.
#       * \param[in] p_src the first eigen vector
#       * \param[in] p_tgt the second eigen vector
#       */
#     inline double
#     l2Sqr (const Eigen::Vector4f &p_src, const Eigen::Vector4f &p_tgt) 
#     {
#       return ((p_src - p_tgt).squaredNorm ());
#     }

# 
# ###

# eigen.h
# # 
# #include <Eigen/Core>
# #include <Eigen/Geometry>
# #include <unsupported/Eigen/Polynomials>
# #include <Eigen/Dense>
###

# elch.h
# template <typename PointT>
# class ELCH : public PCLBase<PointT>
cdef extern from "pcl/registration/elch.h" namespace "pcl::registration" nogil:
    cdef cppclass ELCH[T](cpp.PCLBase[T]):
        ELCH()
#       public:
#         typedef boost::shared_ptr< ELCH<PointT> > Ptr;
#         typedef boost::shared_ptr< const ELCH<PointT> > ConstPtr;
#         typedef pcl::PointCloud<PointT> PointCloud;
#         typedef typename PointCloud::Ptr PointCloudPtr;
#         typedef typename PointCloud::ConstPtr PointCloudConstPtr;
#         struct Vertex
#         {
#           Vertex () : cloud () {}
#           PointCloudPtr cloud;
#         };
# 
#         /** \brief graph structure to hold the SLAM graph */
#         typedef boost::adjacency_list<
#           boost::listS, boost::vecS, boost::undirectedS,
#           Vertex,
#           boost::no_property>
#         LoopGraph;
#         typedef boost::shared_ptr< LoopGraph > LoopGraphPtr;
#         typedef typename pcl::Registration<PointT, PointT> Registration;
#         typedef typename Registration::Ptr RegistrationPtr;
#         typedef typename Registration::ConstPtr RegistrationConstPtr;
#
#         /** \brief Add a new point cloud to the internal graph.
#          * \param[in] cloud the new point cloud
#          */
#         inline void
#         addPointCloud (PointCloudPtr cloud)
# 
#         /** \brief Getter for the internal graph. */
#         inline LoopGraphPtr
#         getLoopGraph ()
# 
#         /** \brief Setter for a new internal graph.
#          * \param[in] loop_graph the new graph
#          */
#         inline void
#         setLoopGraph (LoopGraphPtr loop_graph)
# 
#         /** \brief Getter for the first scan of a loop. */
#         inline typename boost::graph_traits<LoopGraph>::vertex_descriptor
#         getLoopStart ()
#
#         /** \brief Setter for the first scan of a loop.
#          * \param[in] loop_start the scan that starts the loop
#          */
#         inline void
#         setLoopStart (const typename boost::graph_traits<LoopGraph>::vertex_descriptor &loop_start)
#
#         /** \brief Getter for the last scan of a loop. */
#         inline typename boost::graph_traits<LoopGraph>::vertex_descriptor
#         getLoopEnd ()
# 
#         /** \brief Setter for the last scan of a loop.
#          * \param[in] loop_end the scan that ends the loop
#          */
#         inline void
#         setLoopEnd (const typename boost::graph_traits<LoopGraph>::vertex_descriptor &loop_end)
# 
#         /** \brief Getter for the registration algorithm. */
#         inline RegistrationPtr
#         getReg ()
# 
#         /** \brief Setter for the registration algorithm.
#          * \param[in] reg the registration algorithm used to compute the transformation between the start and the end of the loop
#          */
#         inline void setReg (RegistrationPtr reg)
# 
#         /** \brief Getter for the transformation between the first and the last scan. */
#         inline Eigen::Matrix4f getLoopTransform ()
# 
#         /** \brief Setter for the transformation between the first and the last scan.
#          * \param[in] loop_transform the transformation between the first and the last scan
#          */
#         inline void setLoopTransform (const Eigen::Matrix4f &loop_transform)
# 
#         /** \brief Computes now poses for all point clouds by closing the loop
#          * between start and end point cloud. This will transform all given point
#          * clouds for now!
#          */
#         void compute ();
#       protected:
#         using PCLBase<PointT>::deinitCompute;
# 
#         /** \brief This method should get called before starting the actual computation. */
#         virtual bool initCompute ();
#       public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###
# 
# # exceptions.h
# # pcl/exceptions
# #  /** \class SolverDidntConvergeException
# #     * \brief An exception that is thrown when the non linear solver didn't converge
# #     */
# #   class PCL_EXPORTS SolverDidntConvergeException : public PCLException
# #   {
# #     public:
# #     
# #     SolverDidntConvergeException (const std::string& error_description,
# #                                   const std::string& file_name = "",
# #                                   const std::string& function_name = "" ,
# #                                   unsigned line_number = 0) throw ()
# #       : pcl::PCLException (error_description, file_name, function_name, line_number) { }
# #   } ;
# # 
# #  /** \class NotEnoughPointsException
# #     * \brief An exception that is thrown when the number of correspondants is not equal
# #     * to the minimum required
# #     */
# #   class PCL_EXPORTS NotEnoughPointsException : public PCLException
# #   {
# #     public:
# #     
# #     NotEnoughPointsException (const std::string& error_description,
# #                               const std::string& file_name = "",
# #                               const std::string& function_name = "" ,
# #                               unsigned line_number = 0) throw ()
# #       : pcl::PCLException (error_description, file_name, function_name, line_number) { }
# #   } ;
# # 
# ###

# gicp6d.h
# namespace pcl
#   struct EIGEN_ALIGN16 _PointXYZLAB
#   {
#     PCL_ADD_POINT4D; // this adds the members x,y,z
#     union
#     {
#       struct
#       {
#         float L;
#         float a;
#         float b;
#       };
#       float data_lab[4];
#     };
#     EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#   };
# 
#   /** \brief A custom point type for position and CIELAB color value */
#   struct PointXYZLAB : public _PointXYZLAB
#   {
#     inline PointXYZLAB ()
#     {
#       x = y = z = 0.0f; data[3]     = 1.0f;  // important for homogeneous coordinates
#       L = a = b = 0.0f; data_lab[3] = 0.0f;
#     }
#   };
# }
# 
# // register the custom point type in PCL
# POINT_CLOUD_REGISTER_POINT_STRUCT(pcl::_PointXYZLAB,
#     (float, x, x)
#     (float, y, y)
#     (float, z, z)
#     (float, L, L)
#     (float, a, a)
#     (float, b, b)
# )
# POINT_CLOUD_REGISTER_POINT_WRAPPER(pcl::PointXYZLAB, pcl::_PointXYZLAB)
# 
# namespace pcl
# {
#   /** \brief GeneralizedIterativeClosestPoint6D integrates L*a*b* color space information into the
#    * Generalized Iterative Closest Point (GICP) algorithm.
#    *
#    * The suggested input is PointXYZRGBA.
#    *
#    * \note If you use this code in any academic work, please cite:
#    *
#    * - M. Korn, M. Holzkothen, J. Pauli
#    * Color Supported Generalized-ICP.
#    * In Proceedings of VISAPP 2014 - International Conference on Computer Vision Theory and Applications,
#    * Lisbon, Portugal, January 2014.
#    *
#    * \author Martin Holzkothen, Michael Korn
#    * \ingroup registration
#    */
#   class PCL_EXPORTS GeneralizedIterativeClosestPoint6D : public GeneralizedIterativeClosestPoint<PointXYZRGBA, PointXYZRGBA>
#   {
#     typedef PointXYZRGBA PointSource;
#     typedef PointXYZRGBA PointTarget;
# 
#     public:
# 
#       /** \brief constructor.
#        *
#        * \param[in] lab_weight the color weight
#        */
#       GeneralizedIterativeClosestPoint6D (float lab_weight = 0.032f);
# 
#       /** \brief Provide a pointer to the input source
#        * (e.g., the point cloud that we want to align to the target)
#        *
#        * \param[in] cloud the input point cloud source
#        */
#       void
#       setInputSource (const PointCloudSourceConstPtr& cloud);
# 
#       /** \brief Provide a pointer to the input target
#        * (e.g., the point cloud that we want to align the input source to)
#        *
#        * \param[in] cloud the input point cloud target
#        */
#       void
#       setInputTarget (const PointCloudTargetConstPtr& target);
# 
#     protected:
# 
#       /** \brief Rigid transformation computation method  with initial guess.
#        * \param output the transformed input point cloud dataset using the rigid transformation found
#        * \param guess the initial guess of the transformation to compute
#        */
#       void
#       computeTransformation (PointCloudSource& output,
#           const Eigen::Matrix4f& guess);
# 
#       /** \brief Search for the closest nearest neighbor of a given point.
#        * \param query the point to search a nearest neighbour for
#        * \param index vector of size 1 to store the index of the nearest neighbour found
#        * \param distance vector of size 1 to store the distance to nearest neighbour found
#        */
#       inline bool
#       searchForNeighbors (const PointXYZLAB& query, std::vector<int>& index, std::vector<float>& distance);
# 
#     protected:
#       /** \brief Holds the converted (LAB) data cloud. */
#       pcl::PointCloud<PointXYZLAB>::Ptr cloud_lab_;
# 
#       /** \brief Holds the converted (LAB) model cloud. */
#       pcl::PointCloud<PointXYZLAB>::Ptr target_lab_;
# 
#       /** \brief 6d-tree to search in model cloud. */
#       KdTreeFLANN<PointXYZLAB> target_tree_lab_;
# 
#       /** \brief The color weight. */
#       float lab_weight_;
# 
#       /**  \brief Custom point representation to perform kdtree searches in more than 3 (i.e. in all 6) dimensions. */
#       class MyPointRepresentation : public PointRepresentation<PointXYZLAB>
#       {
#           using PointRepresentation<PointXYZLAB>::nr_dimensions_;
#           using PointRepresentation<PointXYZLAB>::trivial_;
# 
#         public:
#           typedef boost::shared_ptr<MyPointRepresentation> Ptr;
#           typedef boost::shared_ptr<const MyPointRepresentation> ConstPtr;
# 
#           MyPointRepresentation ()
#           {
#             nr_dimensions_ = 6;
#             trivial_ = false;
#           }
# 
#           virtual
#           ~MyPointRepresentation ()
#           {
#           }
# 
#           inline Ptr
#           makeShared () const
#           {
#             return Ptr (new MyPointRepresentation (*this));
#           }
# 
#           virtual void
#           copyToFloatArray (const PointXYZLAB &p, float * out) const
#           {
#             // copy all of the six values
#             out[0] = p.x;
#             out[1] = p.y;
#             out[2] = p.z;
#             out[3] = p.L;
#             out[4] = p.a;
#             out[5] = p.b;
#           }
#       };
# 
#       /** \brief Enables 6d searches with kd-tree class using the color weight. */
#       MyPointRepresentation point_rep_;
#   };
###

# ia_ransac.h
# template <typename PointSource, typename PointTarget, typename FeatureT>
# class SampleConsensusInitialAlignment : public Registration<PointSource, PointTarget>
cdef extern from "pcl/registration/ia_ransac.h" namespace "pcl" nogil:
    cdef cppclass SampleConsensusInitialAlignment[Source, Target, Feature](Registration[Source, Target]):
        SampleConsensusInitialAlignment() except +
        # public:
        # using Registration<PointSource, PointTarget>::reg_name_;
        # using Registration<PointSource, PointTarget>::input_;
        # using Registration<PointSource, PointTarget>::indices_;
        # using Registration<PointSource, PointTarget>::target_;
        # using Registration<PointSource, PointTarget>::final_transformation_;
        # using Registration<PointSource, PointTarget>::transformation_;
        # using Registration<PointSource, PointTarget>::corr_dist_threshold_;
        # using Registration<PointSource, PointTarget>::min_number_correspondences_;
        # using Registration<PointSource, PointTarget>::max_iterations_;
        # using Registration<PointSource, PointTarget>::tree_;
        # using Registration<PointSource, PointTarget>::transformation_estimation_;
        # using Registration<PointSource, PointTarget>::getClassName;
        # ctypedef typename Registration<PointSource, PointTarget>::PointCloudSource PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef typename Registration<PointSource, PointTarget>::PointCloudTarget PointCloudTarget;
        # ctypedef PointIndices::Ptr PointIndicesPtr;
        # ctypedef PointIndices::ConstPtr PointIndicesConstPtr;
        # ctypedef pcl::PointCloud<FeatureT> FeatureCloud;
        # ctypedef typename FeatureCloud::Ptr FeatureCloudPtr;
        # ctypedef typename FeatureCloud::ConstPtr FeatureCloudConstPtr;
        # cdef cppclass ErrorFunctor
        # {
        #   public:
        #     virtual ~ErrorFunctor () {}
        #     virtual float operator () (float d) const = 0;
        # };
        # class HuberPenalty : public ErrorFunctor
        # cdef cppclass HuberPenalty(ErrorFunctor)
        #     HuberPenalty ()
        #   public:
        #     HuberPenalty (float threshold)
        #     virtual float operator () (float e) const
        #     { 
        #       if (e <= threshold_)
        #         return (0.5 * e*e); 
        #       else
        #         return (0.5 * threshold_ * (2.0 * fabs (e) - threshold_));
        #     }
        #   protected:
        #     float threshold_;
        # };
        # class TruncatedError : public ErrorFunctor
        # cdef cppclass TruncatedError(ErrorFunctor)
        #     TruncatedError ()
        #   public:
        #     virtual ~TruncatedError () {}
        #     TruncatedError (float threshold) : threshold_ (threshold) {}
        #     virtual float operator () (float e) const
        #     { 
        #       if (e <= threshold_)
        #         return (e / threshold_);
        #       else
        #         return (1.0);
        #     }
        #   protected:
        #     float threshold_;
        # };
        # typedef typename KdTreeFLANN<FeatureT>::Ptr FeatureKdTreePtr; 
        # /** \brief Provide a boost shared pointer to the source point cloud's feature descriptors
        #   * \param features the source point cloud's features
        #   */
        # void 
        # setSourceFeatures (const FeatureCloudConstPtr &features);
        # /** \brief Get a pointer to the source point cloud's features */
        # inline FeatureCloudConstPtr const 
        # getSourceFeatures () { return (input_features_); }
        # /** \brief Provide a boost shared pointer to the target point cloud's feature descriptors
        #   * \param features the target point cloud's features
        #   */
        # void 
        # setTargetFeatures (const FeatureCloudConstPtr &features);
        # /** \brief Get a pointer to the target point cloud's features */
        # inline FeatureCloudConstPtr const 
        # getTargetFeatures () { return (target_features_); }
        # /** \brief Set the minimum distances between samples
        #   * \param min_sample_distance the minimum distances between samples
        #   */
        # void 
        # setMinSampleDistance (float min_sample_distance) { min_sample_distance_ = min_sample_distance; }
        # /** \brief Get the minimum distances between samples, as set by the user */
        # float 
        # getMinSampleDistance () { return (min_sample_distance_); }
        # /** \brief Set the number of samples to use during each iteration
        #   * \param nr_samples the number of samples to use during each iteration
        #   */
        # void 
        # setNumberOfSamples (int nr_samples) { nr_samples_ = nr_samples; }
        # /** \brief Get the number of samples to use during each iteration, as set by the user */
        # int 
        # getNumberOfSamples () { return (nr_samples_); }
        # /** \brief Set the number of neighbors to use when selecting a random feature correspondence.  A higher value will
        #   * add more randomness to the feature matching.
        #   * \param k the number of neighbors to use when selecting a random feature correspondence.
        #   */
        # void
        # setCorrespondenceRandomness (int k) { k_correspondences_ = k; }
        # /** \brief Get the number of neighbors used when selecting a random feature correspondence, as set by the user */
        # int
        # getCorrespondenceRandomness () { return (k_correspondences_); }
        # /** \brief Specify the error function to minimize
        #  * \note This call is optional.  TruncatedError will be used by default
        #  * \param[in] error_functor a shared pointer to a subclass of SampleConsensusInitialAlignment::ErrorFunctor
        #  */
        # void
        # setErrorFunction (const boost::shared_ptr<ErrorFunctor> & error_functor) { error_functor_ = error_functor; }
        # /** \brief Get a shared pointer to the ErrorFunctor that is to be minimized  
        #  * \return A shared pointer to a subclass of SampleConsensusInitialAlignment::ErrorFunctor
        #  */
        # boost::shared_ptr<ErrorFunctor>
        # getErrorFunction () { return (error_functor_); }
        # protected:
        # /** \brief Choose a random index between 0 and n-1
        #   * \param n the number of possible indices to choose from
        #   */
        # inline int 
        # getRandomIndex (int n) { return (static_cast<int> (n * (rand () / (RAND_MAX + 1.0)))); };
        # /** \brief Select \a nr_samples sample points from cloud while making sure that their pairwise distances are 
        #   * greater than a user-defined minimum distance, \a min_sample_distance.
        #   * \param cloud the input point cloud
        #   * \param nr_samples the number of samples to select
        #   * \param min_sample_distance the minimum distance between any two samples
        #   * \param sample_indices the resulting sample indices
        #   */
        # void 
        # selectSamples (const PointCloudSource &cloud, int nr_samples, float min_sample_distance, 
        #                std::vector<int> &sample_indices);
        # /** \brief For each of the sample points, find a list of points in the target cloud whose features are similar to 
        #   * the sample points' features. From these, select one randomly which will be considered that sample point's 
        #   * correspondence. 
        #   * \param input_features a cloud of feature descriptors
        #   * \param sample_indices the indices of each sample point
        #   * \param corresponding_indices the resulting indices of each sample's corresponding point in the target cloud
        #   */
        # void 
        # findSimilarFeatures (const FeatureCloud &input_features, const std::vector<int> &sample_indices, 
        #                      std::vector<int> &corresponding_indices);
        # /** \brief An error metric for that computes the quality of the alignment between the given cloud and the target.
        #   * \param cloud the input cloud
        #   * \param threshold distances greater than this value are capped
        #   */
        # float 
        # computeErrorMetric (const PointCloudSource &cloud, float threshold);
        # /** \brief Rigid transformation computation method.
        #   * \param output the transformed input point cloud dataset using the rigid transformation found
        #   */
        # virtual void 
        # computeTransformation (PointCloudSource &output, const Eigen::Matrix4f& guess);
        # /** \brief The source point cloud's feature descriptors. */
        # FeatureCloudConstPtr input_features_;
        # /** \brief The target point cloud's feature descriptors. */
        # FeatureCloudConstPtr target_features_;  
        # /** \brief The number of samples to use during each iteration. */
        # int nr_samples_;
        # /** \brief The minimum distances between samples. */
        # float min_sample_distance_;
        # /** \brief The number of neighbors to use when selecting a random feature correspondence. */
        # int k_correspondences_;
        # /** \brief The KdTree used to compare feature descriptors. */
        # FeatureKdTreePtr feature_tree_;               
        # /** */
        # boost::shared_ptr<ErrorFunctor> error_functor_;
        # public:
        # EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

# joint_icp.h
# namespace pcl
# {
#   /** \brief @b JointIterativeClosestPoint extends ICP to multiple frames which
#    *  share the same transform. This is particularly useful when solving for 
#    *  camera extrinsics using multiple observations. When given a single pair of 
#    *  clouds, this reduces to vanilla ICP.
#     *
#     * \author Stephen Miller
#     * \ingroup registration
#     */
#   template <typename PointSource, typename PointTarget, typename Scalar = float>
#   class JointIterativeClosestPoint : public IterativeClosestPoint<PointSource, PointTarget, Scalar>
#   {
#     public:
#       typedef typename IterativeClosestPoint<PointSource, PointTarget, Scalar>::PointCloudSource PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#       typedef typename IterativeClosestPoint<PointSource, PointTarget, Scalar>::PointCloudTarget PointCloudTarget;
#       typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#       typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
# 
#       typedef pcl::search::KdTree<PointTarget> KdTree;
#       typedef typename pcl::search::KdTree<PointTarget>::Ptr KdTreePtr;
# 
#       typedef pcl::search::KdTree<PointSource> KdTreeReciprocal;
#       typedef typename KdTree::Ptr KdTreeReciprocalPtr;
# 
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       typedef boost::shared_ptr<JointIterativeClosestPoint<PointSource, PointTarget, Scalar> > Ptr;
#       typedef boost::shared_ptr<const JointIterativeClosestPoint<PointSource, PointTarget, Scalar> > ConstPtr;
# 
#       typedef typename pcl::registration::CorrespondenceEstimationBase<PointSource, PointTarget, Scalar> CorrespondenceEstimation;
#       typedef typename CorrespondenceEstimation::Ptr CorrespondenceEstimationPtr;
#       typedef typename CorrespondenceEstimation::ConstPtr CorrespondenceEstimationConstPtr;
# 
# 
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::reg_name_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::getClassName;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::setInputSource;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::input_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::indices_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::target_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::nr_iterations_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::max_iterations_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::previous_transformation_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::final_transformation_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::transformation_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::transformation_epsilon_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::converged_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::corr_dist_threshold_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::inlier_threshold_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::min_number_correspondences_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::update_visualizer_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::euclidean_fitness_epsilon_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::correspondences_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::transformation_estimation_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::correspondence_estimation_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::correspondence_rejectors_;
#       
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::use_reciprocal_correspondence_;
#       
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::convergence_criteria_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::source_has_normals_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::target_has_normals_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::need_source_blob_;
#       using IterativeClosestPoint<PointSource, PointTarget, Scalar>::need_target_blob_;
# 
# 
#       typedef typename IterativeClosestPoint<PointSource, PointTarget, Scalar>::Matrix4 Matrix4;
# 
#       /** \brief Empty constructor. */
#       JointIterativeClosestPoint ()
#       {
#         IterativeClosestPoint<PointSource, PointTarget, Scalar> ();
#         reg_name_ = "JointIterativeClosestPoint";
#       };
# 
#       /** \brief Empty destructor */
#       virtual ~JointIterativeClosestPoint () {}
# 
# 
#       /** \brief Provide a pointer to the input source 
#         * (e.g., the point cloud that we want to align to the target)
#         */
#       virtual void
#       setInputSource (const PointCloudSourceConstPtr& /*cloud*/)
#       {
#         PCL_WARN ("[pcl::%s::setInputSource] Warning; JointIterativeClosestPoint expects multiple clouds. Please use addInputSource.", 
#             getClassName ().c_str ());
#         return;
#       }
# 
#       /** \brief Add a source cloud to the joint solver
#         *
#         * \param[in] cloud source cloud
#         */
#       inline void
#       addInputSource (const PointCloudSourceConstPtr &cloud)
#       {
#         // Set the parent InputSource, just to get all cached values (e.g. the existence of normals).
#         if (sources_.empty ())
#           IterativeClosestPoint<PointSource, PointTarget, Scalar>::setInputSource (cloud);
#         sources_.push_back (cloud);
#       }
#       
#       /** \brief Provide a pointer to the input target 
#         * (e.g., the point cloud that we want to align to the target)
#         */
#       virtual void
#       setInputTarget (const PointCloudTargetConstPtr& /*cloud*/)
#       {
#         PCL_WARN ("[pcl::%s::setInputTarget] Warning; JointIterativeClosestPoint expects multiple clouds. Please use addInputTarget.", 
#             getClassName ().c_str ());
#         return;
#       }
# 
#       /** \brief Add a target cloud to the joint solver
#         *
#         * \param[in] cloud target cloud
#         */
#       inline void
#       addInputTarget (const PointCloudTargetConstPtr &cloud)
#       {
#         // Set the parent InputTarget, just to get all cached values (e.g. the existence of normals).
#         if (targets_.empty ())
#           IterativeClosestPoint<PointSource, PointTarget, Scalar>::setInputTarget (cloud);
#         targets_.push_back (cloud);
#       }
# 
#       /** \brief Add a manual correspondence estimator
#         * If you choose to do this, you must add one for each 
#         * input source / target pair. They do not need to have trees 
#         * or input clouds set ahead of time.
#         *
#         * \param[in] ce Correspondence estimation
#         */
#       inline void
#       addCorrespondenceEstimation (CorrespondenceEstimationPtr ce)
#       {
#         correspondence_estimations_.push_back (ce);
#       }
# 
#       /** \brief Reset my list of input sources
#         */
#       inline void
#       clearInputSources ()
#       { sources_.clear (); }
# 
#       /** \brief Reset my list of input targets
#         */
#       inline void
#       clearInputTargets ()
#       { targets_.clear (); }
# 
#       /** \brief Reset my list of correspondence estimation methods.
#         */
#       inline void
#       clearCorrespondenceEstimations ()
#       { correspondence_estimations_.clear (); }
# 
# 
#     protected:
# 
#       /** \brief Rigid transformation computation method  with initial guess.
#         * \param output the transformed input point cloud dataset using the rigid transformation found
#         * \param guess the initial guess of the transformation to compute
#         */
#       virtual void 
#       computeTransformation (PointCloudSource &output, const Matrix4 &guess);
#       
#       /** \brief Looks at the Estimators and Rejectors and determines whether their blob-setter methods need to be called */
#       void
#       determineRequiredBlobData ();
# 
#       std::vector<PointCloudSourceConstPtr> sources_;
#       std::vector<PointCloudTargetConstPtr> targets_;
#       std::vector<CorrespondenceEstimationPtr> correspondence_estimations_;
#   };
###

# lum.h
# namespace Eigen
# {
#   typedef Eigen::Matrix<float, 6, 1> Vector6f;
#   typedef Eigen::Matrix<float, 6, 6> Matrix6f;
# }
# 
# namespace pcl
# {
#   namespace registration
#   {
#     /** \brief Globally Consistent Scan Matching based on an algorithm by Lu and Milios.
#       * \details A GraphSLAM algorithm where registration data is managed in a graph:
#       * <ul>
#       *  <li>Vertices represent poses and hold the point cloud data and relative transformations.</li>
#       *  <li>Edges represent pose constraints and hold the correspondence data between two point clouds.</li>
#       * </ul>
#       * Computation uses the first point cloud in the SLAM graph as a reference pose and attempts to align all other point clouds to it simultaneously.
#       * For more information:
#       * <ul><li>
#       * F. Lu, E. Milios,
#       * Globally Consistent Range Scan Alignment for Environment Mapping,
#       * Autonomous Robots 4, April 1997
#       * </li><li>
#       * Dorit Borrmann, Jan Elseberg, Kai Lingemann, Andreas Nuchter, and Joachim Hertzberg,
#       * The Efficient Extension of Globally Consistent Scan Matching to 6 DoF,
#       * In Proceedings of the 4th International Symposium on 3D Data Processing, Visualization and Transmission (3DPVT '08), June 2008
#       * </li></ul>
#       * Usage example:
#       * \code
#       * pcl::registration::LUM<pcl::PointXYZ> lum;
#       * // Add point clouds as vertices to the SLAM graph
#       * lum.addPointCloud (cloud_0);
#       * lum.addPointCloud (cloud_1);
#       * lum.addPointCloud (cloud_2);
#       * // Use your favorite pairwise correspondence estimation algorithm(s)
#       * corrs_0_to_1 = someAlgo (cloud_0, cloud_1);
#       * corrs_1_to_2 = someAlgo (cloud_1, cloud_2);
#       * corrs_2_to_0 = someAlgo (lum.getPointCloud (2), lum.getPointCloud (0));
#       * // Add the correspondence results as edges to the SLAM graph
#       * lum.setCorrespondences (0, 1, corrs_0_to_1);
#       * lum.setCorrespondences (1, 2, corrs_1_to_2);
#       * lum.setCorrespondences (2, 0, corrs_2_to_0);
#       * // Change the computation parameters
#       * lum.setMaxIterations (5);
#       * lum.setConvergenceThreshold (0.0);
#       * // Perform the actual LUM computation
#       * lum.compute ();
#       * // Return the concatenated point cloud result
#       * cloud_out = lum.getConcatenatedCloud ();
#       * // Return the separate point cloud transformations
#       * for(int i = 0; i < lum.getNumVertices (); i++)
#       * {
#       *   transforms_out[i] = lum.getTransformation (i);
#       * }
#       * \endcode
#       * \author Frits Florentinus, Jochen Sprickerhof
#       * \ingroup registration
#       */
#     template<typename PointT>
#     class LUM
#     {
#       public:
#         typedef boost::shared_ptr<LUM<PointT> > Ptr;
#         typedef boost::shared_ptr<const LUM<PointT> > ConstPtr;
# 
#         typedef pcl::PointCloud<PointT> PointCloud;
#         typedef typename PointCloud::Ptr PointCloudPtr;
#         typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#         struct VertexProperties
#         {
#           PointCloudPtr cloud_;
#           Eigen::Vector6f pose_;
#           EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#         };
#         struct EdgeProperties
#         {
#           pcl::CorrespondencesPtr corrs_;
#           Eigen::Matrix6f cinv_;
#           Eigen::Vector6f cinvd_;
#           EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#         };
# 
#         typedef boost::adjacency_list<boost::eigen_vecS, boost::eigen_vecS, boost::bidirectionalS, VertexProperties, EdgeProperties, boost::no_property, boost::eigen_listS> SLAMGraph;
#         typedef boost::shared_ptr<SLAMGraph> SLAMGraphPtr;
#         typedef typename SLAMGraph::vertex_descriptor Vertex;
#         typedef typename SLAMGraph::edge_descriptor Edge;
# 
#         /** \brief Empty constructor.
#           */
#         LUM () 
#           : slam_graph_ (new SLAMGraph)
#           , max_iterations_ (5)
#           , convergence_threshold_ (0.0)
#         {
#         }
# 
#         /** \brief Set the internal SLAM graph structure.
#           * \details All data used and produced by LUM is stored in this boost::adjacency_list.
#           * It is recommended to use the LUM class itself to build the graph.
#           * This method could otherwise be useful for managing several SLAM graphs in one instance of LUM.
#           * \param[in] slam_graph The new SLAM graph.
#           */
#         inline void
#         setLoopGraph (const SLAMGraphPtr &slam_graph);
# 
#         /** \brief Get the internal SLAM graph structure.
#           * \details All data used and produced by LUM is stored in this boost::adjacency_list.
#           * It is recommended to use the LUM class itself to build the graph.
#           * This method could otherwise be useful for managing several SLAM graphs in one instance of LUM.
#           * \return The current SLAM graph.
#           */
#         inline SLAMGraphPtr
#         getLoopGraph () const;
# 
#         /** \brief Get the number of vertices in the SLAM graph.
#           * \return The current number of vertices in the SLAM graph.
#           */
#         typename SLAMGraph::vertices_size_type
#         getNumVertices () const;
# 
#         /** \brief Set the maximum number of iterations for the compute() method.
#           * \details The compute() method finishes when max_iterations are met or when the convergence criteria is met.
#           * \param[in] max_iterations The new maximum number of iterations (default = 5).
#           */
#         void
#         setMaxIterations (int max_iterations);
# 
#         /** \brief Get the maximum number of iterations for the compute() method.
#           * \details The compute() method finishes when max_iterations are met or when the convergence criteria is met.
#           * \return The current maximum number of iterations (default = 5).
#           */
#         inline int
#         getMaxIterations () const;
# 
#         /** \brief Set the convergence threshold for the compute() method.
#           * \details When the compute() method computes the new poses relative to the old poses, it will determine the length of the difference vector.
#           * When the average length of all difference vectors becomes less than the convergence_threshold the convergence is assumed to be met.
#           * \param[in] convergence_threshold The new convergence threshold (default = 0.0).
#           */
#         void
#         setConvergenceThreshold (float convergence_threshold);
# 
#         /** \brief Get the convergence threshold for the compute() method.
#           * \details When the compute() method computes the new poses relative to the old poses, it will determine the length of the difference vector.
#           * When the average length of all difference vectors becomes less than the convergence_threshold the convergence is assumed to be met.
#           * \return The current convergence threshold (default = 0.0).
#           */
#         inline float
#         getConvergenceThreshold () const;
# 
#         /** \brief Add a new point cloud to the SLAM graph.
#           * \details This method will add a new vertex to the SLAM graph and attach a point cloud to that vertex.
#           * Optionally you can specify a pose estimate for this point cloud.
#           * A vertex' pose is always relative to the first vertex in the SLAM graph, i.e. the first point cloud that was added.
#           * Because this first vertex is the reference, you can not set a pose estimate for this vertex.
#           * Providing pose estimates to the vertices in the SLAM graph will reduce overall computation time of LUM.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] cloud The new point cloud.
#           * \param[in] pose (optional) The pose estimate relative to the reference pose (first point cloud that was added).
#           * \return The vertex descriptor of the newly created vertex.
#           */
#         Vertex
#         addPointCloud (const PointCloudPtr &cloud, const Eigen::Vector6f &pose = Eigen::Vector6f::Zero ());
# 
#         /** \brief Change a point cloud on one of the SLAM graph's vertices.
#           * \details This method will change the point cloud attached to an existing vertex and will not alter the SLAM graph structure.
#           * Note that the correspondences attached to this vertex will not change and may need to be updated manually.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to change the point cloud.
#           * \param[in] cloud The new point cloud for that vertex.
#           */
#         inline void
#         setPointCloud (const Vertex &vertex, const PointCloudPtr &cloud);
# 
#         /** \brief Return a point cloud from one of the SLAM graph's vertices.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to return the point cloud.
#           * \return The current point cloud for that vertex.
#           */
#         inline PointCloudPtr
#         getPointCloud (const Vertex &vertex) const;
# 
#         /** \brief Change a pose estimate on one of the SLAM graph's vertices.
#           * \details A vertex' pose is always relative to the first vertex in the SLAM graph, i.e. the first point cloud that was added.
#           * Because this first vertex is the reference, you can not set a pose estimate for this vertex.
#           * Providing pose estimates to the vertices in the SLAM graph will reduce overall computation time of LUM.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to set the pose estimate.
#           * \param[in] pose The new pose estimate for that vertex.
#           */
#         inline void
#         setPose (const Vertex &vertex, const Eigen::Vector6f &pose);
# 
#         /** \brief Return a pose estimate from one of the SLAM graph's vertices.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to return the pose estimate.
#           * \return The current pose estimate of that vertex.
#           */
#         inline Eigen::Vector6f
#         getPose (const Vertex &vertex) const;
# 
#         /** \brief Return a pose estimate from one of the SLAM graph's vertices as an affine transformation matrix.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to return the transformation matrix.
#           * \return The current transformation matrix of that vertex.
#           */
#         inline Eigen::Affine3f
#         getTransformation (const Vertex &vertex) const;
# 
#         /** \brief Add/change a set of correspondences for one of the SLAM graph's edges.
#           * \details The edges in the SLAM graph are directional and point from source vertex to target vertex.
#           * The query indices of the correspondences, index the points at the source vertex' point cloud.
#           * The matching indices of the correspondences, index the points at the target vertex' point cloud.
#           * If no edge was present at the specified location, this method will add a new edge to the SLAM graph and attach the correspondences to that edge.
#           * If the edge was already present, this method will overwrite the correspondence information of that edge and will not alter the SLAM graph structure.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] source_vertex The vertex descriptor of the correspondences' source point cloud.
#           * \param[in] target_vertex The vertex descriptor of the correspondences' target point cloud.
#           * \param[in] corrs The new set of correspondences for that edge.
#           */
#         void
#         setCorrespondences (const Vertex &source_vertex, 
#                             const Vertex &target_vertex, 
#                             const pcl::CorrespondencesPtr &corrs);
# 
#         /** \brief Return a set of correspondences from one of the SLAM graph's edges.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] source_vertex The vertex descriptor of the correspondences' source point cloud.
#           * \param[in] target_vertex The vertex descriptor of the correspondences' target point cloud.
#           * \return The current set of correspondences of that edge.
#           */
#         inline pcl::CorrespondencesPtr
#         getCorrespondences (const Vertex &source_vertex, const Vertex &target_vertex) const;
# 
#         /** \brief Perform LUM's globally consistent scan matching.
#           * \details Computation uses the first point cloud in the SLAM graph as a reference pose and attempts to align all other point clouds to it simultaneously.
#           * <br>
#           * Things to keep in mind:
#           * <ul>
#           *  <li>Only those parts of the graph connected to the reference pose will properly align to it.</li>
#           *  <li>All sets of correspondences should span the same space and need to be sufficient to determine a rigid transformation.</li>
#           *  <li>The algorithm draws it strength from loops in the graph because it will distribute errors evenly amongst those loops.</li>
#           * </ul>
#           * Computation ends when either of the following conditions hold:
#           * <ul>
#           *  <li>The number of iterations reaches max_iterations. Use setMaxIterations() to change.</li>
#           *  <li>The convergence criteria is met. Use setConvergenceThreshold() to change.</li>
#           * </ul>
#           * Computation will change the pose estimates for the vertices of the SLAM graph, not the point clouds attached to them.
#           * The results can be retrieved with getPose(), getTransformation(), getTransformedCloud() or getConcatenatedCloud().
#           */
#         void
#         compute ();
# 
#         /** \brief Return a point cloud from one of the SLAM graph's vertices compounded onto its current pose estimate.
#           * \note Vertex descriptors are typecastable to int.
#           * \param[in] vertex The vertex descriptor of which to return the transformed point cloud.
#           * \return The transformed point cloud of that vertex.
#           */
#         PointCloudPtr
#         getTransformedCloud (const Vertex &vertex) const;
# 
#         /** \brief Return a concatenated point cloud of all the SLAM graph's point clouds compounded onto their current pose estimates.
#           * \return The concatenated transformed point clouds of the entire SLAM graph.
#           */
#         PointCloudPtr
#         getConcatenatedCloud () const;
# 
#       protected:
#         /** \brief Linearized computation of C^-1 and C^-1*D (results stored in slam_graph_). */
#         void
#         computeEdge (const Edge &e);
# 
#         /** \brief Returns a pose corrected 6DoF incidence matrix. */
#         inline Eigen::Matrix6f
#         incidenceCorrection (const Eigen::Vector6f &pose);
# 
#       private:
#         /** \brief The internal SLAM graph structure. */
#         SLAMGraphPtr slam_graph_;
# 
#         /** \brief The maximum number of iterations for the compute() method. */
#         int max_iterations_;
# 
#         /** \brief The convergence threshold for the summed vector lengths of all poses. */
#         float convergence_threshold_;
#     };
#
###

# ndt.h
# namespace pcl
# {
#   /** \brief A 3D Normal Distribution Transform registration implementation for point cloud data.
#     * \note For more information please see
#     * <b>Magnusson, M. (2009). The Three-Dimensional Normal-Distributions Transform  
#     * an Ef珣ient Representation for Registration, Surface Analysis, and Loop Detection.
#     * PhD thesis, Orebro University. Orebro Studies in Technology 36.</b>,
#     * <b>More, J., and Thuente, D. (1994). Line Search Algorithm with Guaranteed Sufficient Decrease
#     * In ACM Transactions on Mathematical Software.</b> and
#     * Sun, W. and Yuan, Y, (2006) Optimization Theory and Methods: Nonlinear Programming. 89-100
#     * \note Math refactored by Todor Stoyanov.
#     * \author Brian Okorn (Space and Naval Warfare Systems Center Pacific)
#     */
#   template<typename PointSource, typename PointTarget>
#   class NormalDistributionsTransform : public Registration<PointSource, PointTarget>
#   {
#     protected:
# 
#       typedef typename Registration<PointSource, PointTarget>::PointCloudSource PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#       typedef typename Registration<PointSource, PointTarget>::PointCloudTarget PointCloudTarget;
#       typedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
#       typedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       /** \brief Typename of searchable voxel grid containing mean and covariance. */
#       typedef VoxelGridCovariance<PointTarget> TargetGrid;
#       /** \brief Typename of pointer to searchable voxel grid. */
#       typedef TargetGrid* TargetGridPtr;
#       /** \brief Typename of const pointer to searchable voxel grid. */
#       typedef const TargetGrid* TargetGridConstPtr;
#       /** \brief Typename of const pointer to searchable voxel grid leaf. */
#       typedef typename TargetGrid::LeafConstPtr TargetGridLeafConstPtr;
# 
# 
#     public:
# 
#       typedef boost::shared_ptr< NormalDistributionsTransform<PointSource, PointTarget> > Ptr;
#       typedef boost::shared_ptr< const NormalDistributionsTransform<PointSource, PointTarget> > ConstPtr;
# 
# 
#       /** \brief Constructor.
#         * Sets \ref outlier_ratio_ to 0.35, \ref step_size_ to 0.05 and \ref resolution_ to 1.0
#         */
#       NormalDistributionsTransform ();
#       
#       /** \brief Empty destructor */
#       virtual ~NormalDistributionsTransform () {}
# 
#       /** \brief Provide a pointer to the input target (e.g., the point cloud that we want to align the input source to).
#         * \param[in] cloud the input point cloud target
#         */
#       inline void
#       setInputTarget (const PointCloudTargetConstPtr &cloud)
#       {
#         Registration<PointSource, PointTarget>::setInputTarget (cloud);
#         init ();
#       }
# 
#       /** \brief Set/change the voxel grid resolution.
#         * \param[in] resolution side length of voxels
#         */
#       inline void
#       setResolution (float resolution)
#       {
#         // Prevents unnessary voxel initiations
#         if (resolution_ != resolution)
#         {
#           resolution_ = resolution;
#           if (input_)
#             init ();
#         }
#       }
# 
#       /** \brief Get voxel grid resolution.
#         * \return side length of voxels
#         */
#       inline float
#       getResolution () const
#       {
#         return (resolution_);
#       }
# 
#       /** \brief Get the newton line search maximum step length.
#         * \return maximum step length
#         */
#       inline double
#       getStepSize () const
#       {
#         return (step_size_);
#       }
# 
#       /** \brief Set/change the newton line search maximum step length.
#         * \param[in] step_size maximum step length
#         */
#       inline void
#       setStepSize (double step_size)
#       {
#         step_size_ = step_size;
#       }
# 
#       /** \brief Get the point cloud outlier ratio.
#         * \return outlier ratio
#         */
#       inline double
#       getOulierRatio () const
#       {
#         return (outlier_ratio_);
#       }
# 
#       /** \brief Set/change the point cloud outlier ratio.
#         * \param[in] outlier_ratio outlier ratio
#         */
#       inline void
#       setOulierRatio (double outlier_ratio)
#       {
#         outlier_ratio_ = outlier_ratio;
#       }
# 
#       /** \brief Get the registration alignment probability.
#         * \return transformation probability
#         */
#       inline double
#       getTransformationProbability () const
#       {
#         return (trans_probability_);
#       }
# 
#       /** \brief Get the number of iterations required to calculate alignment.
#         * \return final number of iterations
#         */
#       inline int
#       getFinalNumIteration () const
#       {
#         return (nr_iterations_);
#       }
# 
#       /** \brief Convert 6 element transformation vector to affine transformation.
#         * \param[in] x transformation vector of the form [x, y, z, roll, pitch, yaw]
#         * \param[out] trans affine transform corresponding to given transfomation vector
#         */
#       static void
#       convertTransform (const Eigen::Matrix<double, 6, 1> &x, Eigen::Affine3f &trans)
#       {
#         trans = Eigen::Translation<float, 3>(float (x (0)), float (x (1)), float (x (2))) *
#                 Eigen::AngleAxis<float>(float (x (3)), Eigen::Vector3f::UnitX ()) *
#                 Eigen::AngleAxis<float>(float (x (4)), Eigen::Vector3f::UnitY ()) *
#                 Eigen::AngleAxis<float>(float (x (5)), Eigen::Vector3f::UnitZ ());
#       }
# 
#       /** \brief Convert 6 element transformation vector to transformation matrix.
#         * \param[in] x transformation vector of the form [x, y, z, roll, pitch, yaw]
#         * \param[out] trans 4x4 transformation matrix corresponding to given transfomation vector
#         */
#       static void
#       convertTransform (const Eigen::Matrix<double, 6, 1> &x, Eigen::Matrix4f &trans)
#       {
#         Eigen::Affine3f _affine;
#         convertTransform (x, _affine);
#         trans = _affine.matrix ();
#       }
# 
#     protected:
# 
#       using Registration<PointSource, PointTarget>::reg_name_;
#       using Registration<PointSource, PointTarget>::getClassName;
#       using Registration<PointSource, PointTarget>::input_;
#       using Registration<PointSource, PointTarget>::indices_;
#       using Registration<PointSource, PointTarget>::target_;
#       using Registration<PointSource, PointTarget>::nr_iterations_;
#       using Registration<PointSource, PointTarget>::max_iterations_;
#       using Registration<PointSource, PointTarget>::previous_transformation_;
#       using Registration<PointSource, PointTarget>::final_transformation_;
#       using Registration<PointSource, PointTarget>::transformation_;
#       using Registration<PointSource, PointTarget>::transformation_epsilon_;
#       using Registration<PointSource, PointTarget>::converged_;
#       using Registration<PointSource, PointTarget>::corr_dist_threshold_;
#       using Registration<PointSource, PointTarget>::inlier_threshold_;
# 
#       using Registration<PointSource, PointTarget>::update_visualizer_;
# 
#       /** \brief Estimate the transformation and returns the transformed source (input) as output.
#         * \param[out] output the resultant input transfomed point cloud dataset
#         */
#       virtual void
#       computeTransformation (PointCloudSource &output)
#       {
#         computeTransformation (output, Eigen::Matrix4f::Identity ());
#       }
# 
#       /** \brief Estimate the transformation and returns the transformed source (input) as output.
#         * \param[out] output the resultant input transfomed point cloud dataset
#         * \param[in] guess the initial gross estimation of the transformation
#         */
#       virtual void
#       computeTransformation (PointCloudSource &output, const Eigen::Matrix4f &guess);
# 
#       /** \brief Initiate covariance voxel structure. */
#       void inline
#       init ()
#       {
#         target_cells_.setLeafSize (resolution_, resolution_, resolution_);
#         target_cells_.setInputCloud ( target_ );
#         // Initiate voxel structure.
#         target_cells_.filter (true);
#       }
# 
#       /** \brief Compute derivatives of probability function w.r.t. the transformation vector.
#         * \note Equation 6.10, 6.12 and 6.13 [Magnusson 2009].
#         * \param[out] score_gradient the gradient vector of the probability function w.r.t. the transformation vector
#         * \param[out] hessian the hessian matrix of the probability function w.r.t. the transformation vector
#         * \param[in] trans_cloud transformed point cloud
#         * \param[in] p the current transform vector
#         * \param[in] compute_hessian flag to calculate hessian, unnessissary for step calculation.
#         */
#       double
#       computeDerivatives (Eigen::Matrix<double, 6, 1> &score_gradient,
#                           Eigen::Matrix<double, 6, 6> &hessian,
#                           PointCloudSource &trans_cloud,
#                           Eigen::Matrix<double, 6, 1> &p,
#                           bool compute_hessian = true);
# 
#       /** \brief Compute individual point contirbutions to derivatives of probability function w.r.t. the transformation vector.
#         * \note Equation 6.10, 6.12 and 6.13 [Magnusson 2009].
#         * \param[in,out] score_gradient the gradient vector of the probability function w.r.t. the transformation vector
#         * \param[in,out] hessian the hessian matrix of the probability function w.r.t. the transformation vector
#         * \param[in] x_trans transformed point minus mean of occupied covariance voxel
#         * \param[in] c_inv covariance of occupied covariance voxel
#         * \param[in] compute_hessian flag to calculate hessian, unnessissary for step calculation.
#         */
#       double
#       updateDerivatives (Eigen::Matrix<double, 6, 1> &score_gradient,
#                          Eigen::Matrix<double, 6, 6> &hessian,
#                          Eigen::Vector3d &x_trans, Eigen::Matrix3d &c_inv,
#                          bool compute_hessian = true);
# 
#       /** \brief Precompute anglular components of derivatives.
#         * \note Equation 6.19 and 6.21 [Magnusson 2009].
#         * \param[in] p the current transform vector
#         * \param[in] compute_hessian flag to calculate hessian, unnessissary for step calculation.
#         */
#       void
#       computeAngleDerivatives (Eigen::Matrix<double, 6, 1> &p, bool compute_hessian = true);
# 
#       /** \brief Compute point derivatives.
#         * \note Equation 6.18-21 [Magnusson 2009].
#         * \param[in] x point from the input cloud
#         * \param[in] compute_hessian flag to calculate hessian, unnessissary for step calculation.
#         */
#       void
#       computePointDerivatives (Eigen::Vector3d &x, bool compute_hessian = true);
# 
#       /** \brief Compute hessian of probability function w.r.t. the transformation vector.
#         * \note Equation 6.13 [Magnusson 2009].
#         * \param[out] hessian the hessian matrix of the probability function w.r.t. the transformation vector
#         * \param[in] trans_cloud transformed point cloud
#         * \param[in] p the current transform vector
#         */
#       void
#       computeHessian (Eigen::Matrix<double, 6, 6> &hessian,
#                       PointCloudSource &trans_cloud,
#                       Eigen::Matrix<double, 6, 1> &p);
# 
#       /** \brief Compute individual point contirbutions to hessian of probability function w.r.t. the transformation vector.
#         * \note Equation 6.13 [Magnusson 2009].
#         * \param[in,out] hessian the hessian matrix of the probability function w.r.t. the transformation vector
#         * \param[in] x_trans transformed point minus mean of occupied covariance voxel
#         * \param[in] c_inv covariance of occupied covariance voxel
#         */
#       void
#       updateHessian (Eigen::Matrix<double, 6, 6> &hessian,
#                      Eigen::Vector3d &x_trans, Eigen::Matrix3d &c_inv);
# 
#       /** \brief Compute line search step length and update transform and probability derivatives using More-Thuente method.
#         * \note Search Algorithm [More, Thuente 1994]
#         * \param[in] x initial transformation vector, \f$ x \f$ in Equation 1.3 (Moore, Thuente 1994) and \f$ \vec{p} \f$ in Algorithm 2 [Magnusson 2009]
#         * \param[in] step_dir descent direction, \f$ p \f$ in Equation 1.3 (Moore, Thuente 1994) and \f$ \delta \vec{p} \f$ normalized in Algorithm 2 [Magnusson 2009]
#         * \param[in] step_init initial step length estimate, \f$ \alpha_0 \f$ in Moore-Thuente (1994) and the noramal of \f$ \delta \vec{p} \f$ in Algorithm 2 [Magnusson 2009]
#         * \param[in] step_max maximum step length, \f$ \alpha_max \f$ in Moore-Thuente (1994)
#         * \param[in] step_min minimum step length, \f$ \alpha_min \f$ in Moore-Thuente (1994)
#         * \param[out] score final score function value, \f$ f(x + \alpha p) \f$ in Equation 1.3 (Moore, Thuente 1994) and \f$ score \f$ in Algorithm 2 [Magnusson 2009]
#         * \param[in,out] score_gradient gradient of score function w.r.t. transformation vector, \f$ f'(x + \alpha p) \f$ in Moore-Thuente (1994) and \f$ \vec{g} \f$ in Algorithm 2 [Magnusson 2009]
#         * \param[out] hessian hessian of score function w.r.t. transformation vector, \f$ f''(x + \alpha p) \f$ in Moore-Thuente (1994) and \f$ H \f$ in Algorithm 2 [Magnusson 2009]
#         * \param[in,out] trans_cloud transformed point cloud, \f$ X \f$ transformed by \f$ T(\vec{p},\vec{x}) \f$ in Algorithm 2 [Magnusson 2009]
#         * \return final step length
#         */
#       double
#       computeStepLengthMT (const Eigen::Matrix<double, 6, 1> &x,
#                            Eigen::Matrix<double, 6, 1> &step_dir,
#                            double step_init,
#                            double step_max, double step_min,
#                            double &score,
#                            Eigen::Matrix<double, 6, 1> &score_gradient,
#                            Eigen::Matrix<double, 6, 6> &hessian,
#                            PointCloudSource &trans_cloud);
# 
#       /** \brief Update interval of possible step lengths for More-Thuente method, \f$ I \f$ in More-Thuente (1994)
#         * \note Updating Algorithm until some value satifies \f$ \psi(\alpha_k) \leq 0 \f$ and \f$ \phi'(\alpha_k) \geq 0 \f$
#         * and Modified Updating Algorithm from then on [More, Thuente 1994].
#         * \param[in,out] a_l first endpoint of interval \f$ I \f$, \f$ \alpha_l \f$ in Moore-Thuente (1994)
#         * \param[in,out] f_l value at first endpoint, \f$ f_l \f$ in Moore-Thuente (1994), \f$ \psi(\alpha_l) \f$ for Update Algorithm and \f$ \phi(\alpha_l) \f$ for Modified Update Algorithm
#         * \param[in,out] g_l derivative at first endpoint, \f$ g_l \f$ in Moore-Thuente (1994), \f$ \psi'(\alpha_l) \f$ for Update Algorithm and \f$ \phi'(\alpha_l) \f$ for Modified Update Algorithm
#         * \param[in,out] a_u second endpoint of interval \f$ I \f$, \f$ \alpha_u \f$ in Moore-Thuente (1994)
#         * \param[in,out] f_u value at second endpoint, \f$ f_u \f$ in Moore-Thuente (1994), \f$ \psi(\alpha_u) \f$ for Update Algorithm and \f$ \phi(\alpha_u) \f$ for Modified Update Algorithm
#         * \param[in,out] g_u derivative at second endpoint, \f$ g_u \f$ in Moore-Thuente (1994), \f$ \psi'(\alpha_u) \f$ for Update Algorithm and \f$ \phi'(\alpha_u) \f$ for Modified Update Algorithm
#         * \param[in] a_t trial value, \f$ \alpha_t \f$ in Moore-Thuente (1994)
#         * \param[in] f_t value at trial value, \f$ f_t \f$ in Moore-Thuente (1994), \f$ \psi(\alpha_t) \f$ for Update Algorithm and \f$ \phi(\alpha_t) \f$ for Modified Update Algorithm
#         * \param[in] g_t derivative at trial value, \f$ g_t \f$ in Moore-Thuente (1994), \f$ \psi'(\alpha_t) \f$ for Update Algorithm and \f$ \phi'(\alpha_t) \f$ for Modified Update Algorithm
#         * \return if interval converges
#         */
#       bool
#       updateIntervalMT (double &a_l, double &f_l, double &g_l,
#                         double &a_u, double &f_u, double &g_u,
#                         double a_t, double f_t, double g_t);
# 
#       /** \brief Select new trial value for More-Thuente method.
#         * \note Trial Value Selection [More, Thuente 1994], \f$ \psi(\alpha_k) \f$ is used for \f$ f_k \f$ and \f$ g_k \f$
#         * until some value satifies the test \f$ \psi(\alpha_k) \leq 0 \f$ and \f$ \phi'(\alpha_k) \geq 0 \f$
#         * then \f$ \phi(\alpha_k) \f$ is used from then on.
#         * \note Interpolation Minimizer equations from Optimization Theory and Methods: Nonlinear Programming By Wenyu Sun, Ya-xiang Yuan (89-100).
#         * \param[in] a_l first endpoint of interval \f$ I \f$, \f$ \alpha_l \f$ in Moore-Thuente (1994)
#         * \param[in] f_l value at first endpoint, \f$ f_l \f$ in Moore-Thuente (1994)
#         * \param[in] g_l derivative at first endpoint, \f$ g_l \f$ in Moore-Thuente (1994)
#         * \param[in] a_u second endpoint of interval \f$ I \f$, \f$ \alpha_u \f$ in Moore-Thuente (1994)
#         * \param[in] f_u value at second endpoint, \f$ f_u \f$ in Moore-Thuente (1994)
#         * \param[in] g_u derivative at second endpoint, \f$ g_u \f$ in Moore-Thuente (1994)
#         * \param[in] a_t previous trial value, \f$ \alpha_t \f$ in Moore-Thuente (1994)
#         * \param[in] f_t value at previous trial value, \f$ f_t \f$ in Moore-Thuente (1994)
#         * \param[in] g_t derivative at previous trial value, \f$ g_t \f$ in Moore-Thuente (1994)
#         * \return new trial value
#         */
#       double
#       trialValueSelectionMT (double a_l, double f_l, double g_l,
#                              double a_u, double f_u, double g_u,
#                              double a_t, double f_t, double g_t);
# 
#       /** \brief Auxilary function used to determin endpoints of More-Thuente interval.
#         * \note \f$ \psi(\alpha) \f$ in Equation 1.6 (Moore, Thuente 1994)
#         * \param[in] a the step length, \f$ \alpha \f$ in More-Thuente (1994)
#         * \param[in] f_a function value at step length a, \f$ \phi(\alpha) \f$ in More-Thuente (1994)
#         * \param[in] f_0 initial function value, \f$ \phi(0) \f$ in Moore-Thuente (1994)
#         * \param[in] g_0 initial function gradiant, \f$ \phi'(0) \f$ in More-Thuente (1994)
#         * \param[in] mu the step length, constant \f$ \mu \f$ in Equation 1.1 [More, Thuente 1994]
#         * \return sufficent decrease value
#         */
#       inline double
#       auxilaryFunction_PsiMT (double a, double f_a, double f_0, double g_0, double mu = 1.e-4)
#       {
#         return (f_a - f_0 - mu * g_0 * a);
#       }
# 
#       /** \brief Auxilary function derivative used to determin endpoints of More-Thuente interval.
#         * \note \f$ \psi'(\alpha) \f$, derivative of Equation 1.6 (Moore, Thuente 1994)
#         * \param[in] g_a function gradient at step length a, \f$ \phi'(\alpha) \f$ in More-Thuente (1994)
#         * \param[in] g_0 initial function gradiant, \f$ \phi'(0) \f$ in More-Thuente (1994)
#         * \param[in] mu the step length, constant \f$ \mu \f$ in Equation 1.1 [More, Thuente 1994]
#         * \return sufficent decrease derivative
#         */
#       inline double
#       auxilaryFunction_dPsiMT (double g_a, double g_0, double mu = 1.e-4)
#       {
#         return (g_a - mu * g_0);
#       }
# 
#       /** \brief The voxel grid generated from target cloud containing point means and covariances. */
#       TargetGrid target_cells_;
# 
#       //double fitness_epsilon_;
# 
#       /** \brief The side length of voxels. */
#       float resolution_;
# 
#       /** \brief The maximum step length. */
#       double step_size_;
# 
#       /** \brief The ratio of outliers of points w.r.t. a normal distribution, Equation 6.7 [Magnusson 2009]. */
#       double outlier_ratio_;
# 
#       /** \brief The normalization constants used fit the point distribution to a normal distribution, Equation 6.8 [Magnusson 2009]. */
#       double gauss_d1_, gauss_d2_;
# 
#       /** \brief The probability score of the transform applied to the input cloud, Equation 6.9 and 6.10 [Magnusson 2009]. */
#       double trans_probability_;
# 
#       /** \brief Precomputed Angular Gradient
#         *
#         * The precomputed angular derivatives for the jacobian of a transformation vector, Equation 6.19 [Magnusson 2009]. 
#         */
#       Eigen::Vector3d j_ang_a_, j_ang_b_, j_ang_c_, j_ang_d_, j_ang_e_, j_ang_f_, j_ang_g_, j_ang_h_;
# 
#       /** \brief Precomputed Angular Hessian
#         *
#         * The precomputed angular derivatives for the hessian of a transformation vector, Equation 6.19 [Magnusson 2009].
#         */
#       Eigen::Vector3d h_ang_a2_, h_ang_a3_,
#                       h_ang_b2_, h_ang_b3_,
#                       h_ang_c2_, h_ang_c3_,
#                       h_ang_d1_, h_ang_d2_, h_ang_d3_,
#                       h_ang_e1_, h_ang_e2_, h_ang_e3_,
#                       h_ang_f1_, h_ang_f2_, h_ang_f3_;
# 
#       /** \brief The first order derivative of the transformation of a point w.r.t. the transform vector, \f$ J_E \f$ in Equation 6.18 [Magnusson 2009]. */
#       Eigen::Matrix<double, 3, 6> point_gradient_;
# 
#       /** \brief The second order derivative of the transformation of a point w.r.t. the transform vector, \f$ H_E \f$ in Equation 6.20 [Magnusson 2009]. */
#       Eigen::Matrix<double, 18, 6> point_hessian_;
# 
#     public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
# 
#   };
###

# ndt_2d.h
# namespace pcl
# {
#   /** \brief @b NormalDistributionsTransform2D provides an implementation of the
#     * Normal Distributions Transform algorithm for scan matching.
#     *
#     * This implementation is intended to match the definition:
#     * Peter Biber and Wolfgang Straser. The normal distributions transform: A
#     * new approach to laser scan matching. In Proceedings of the IEEE In-
#     * ternational Conference on Intelligent Robots and Systems (IROS), pages
#     * 2743 2748, Las Vegas, USA, October 2003.
#     *
#     * \author James Crosby
#     */
#   template <typename PointSource, typename PointTarget>
#   class NormalDistributionsTransform2D : public Registration<PointSource, PointTarget>
#   {
#     typedef typename Registration<PointSource, PointTarget>::PointCloudSource PointCloudSource;
#     typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#     typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#     typedef typename Registration<PointSource, PointTarget>::PointCloudTarget PointCloudTarget;
# 
#     typedef PointIndices::Ptr PointIndicesPtr;
#     typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#     public:
# 
#         typedef boost::shared_ptr< NormalDistributionsTransform2D<PointSource, PointTarget> > Ptr;
#         typedef boost::shared_ptr< const NormalDistributionsTransform2D<PointSource, PointTarget> > ConstPtr;
# 
#       /** \brief Empty constructor. */
#       NormalDistributionsTransform2D ()
#         : Registration<PointSource,PointTarget> (),
#           grid_centre_ (0,0), grid_step_ (1,1), grid_extent_ (20,20), newton_lambda_ (1,1,1)
#       {
#         reg_name_ = "NormalDistributionsTransform2D";
#       }
#       
#       /** \brief Empty destructor */
#       virtual ~NormalDistributionsTransform2D () {}
#  
#       /** \brief centre of the ndt grid (target coordinate system)
#         * \param centre value to set
#         */
#       virtual void
#       setGridCentre (const Eigen::Vector2f& centre) { grid_centre_ = centre; }
# 
#       /** \brief Grid spacing (step) of the NDT grid
#         * \param[in] step value to set
#         */
#       virtual void
#       setGridStep (const Eigen::Vector2f& step) { grid_step_ = step; }
# 
#       /** \brief NDT Grid extent (in either direction from the grid centre)
#         * \param[in] extent value to set
#         */
#       virtual void
#       setGridExtent (const Eigen::Vector2f& extent) { grid_extent_ = extent; }
# 
#       /** \brief NDT Newton optimisation step size parameter
#         * \param[in] lambda step size: 1 is simple newton optimisation, smaller values may improve convergence
#         */
#        virtual void
#        setOptimizationStepSize (const double& lambda) { newton_lambda_ = Eigen::Vector3d (lambda, lambda, lambda); }
# 
#       /** \brief NDT Newton optimisation step size parameter
#         * \param[in] lambda step size: (1,1,1) is simple newton optimisation,
#         * smaller values may improve convergence, or elements may be set to
#         * zero to prevent optimisation over some parameters
#         *
#         * This overload allows control of updates to the individual (x, y,
#         * theta) free parameters in the optimisation. If, for example, theta is
#         * believed to be close to the correct value a small value of lambda[2]
#         * should be used.
#         */
#        virtual void
#        setOptimizationStepSize (const Eigen::Vector3d& lambda) { newton_lambda_ = lambda; }
# 
#     protected:
#       /** \brief Rigid transformation computation method with initial guess.
#         * \param[out] output the transformed input point cloud dataset using the rigid transformation found
#         * \param[in] guess the initial guess of the transformation to compute
#         */
#       virtual void 
#       computeTransformation (PointCloudSource &output, const Eigen::Matrix4f &guess);
# 
#       using Registration<PointSource, PointTarget>::reg_name_;
#       using Registration<PointSource, PointTarget>::target_;
#       using Registration<PointSource, PointTarget>::converged_;
#       using Registration<PointSource, PointTarget>::nr_iterations_;
#       using Registration<PointSource, PointTarget>::max_iterations_;
#       using Registration<PointSource, PointTarget>::transformation_epsilon_;
#       using Registration<PointSource, PointTarget>::transformation_;
#       using Registration<PointSource, PointTarget>::previous_transformation_;      
#       using Registration<PointSource, PointTarget>::final_transformation_;
#       using Registration<PointSource, PointTarget>::update_visualizer_;
#       using Registration<PointSource, PointTarget>::indices_;
# 
#       Eigen::Vector2f grid_centre_;
#       Eigen::Vector2f grid_step_;
#       Eigen::Vector2f grid_extent_;
#       Eigen::Vector3d newton_lambda_;
#     public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#   };
###

# NG : PCL1.7.2 AppVeyor
# ErrorLog
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE\xhash(29): error C2440: 'type cast': cannot convert from 'const pcl::PPFHashMapSearch::HashKeyStruct' to 'std::size_t'
# C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE\xhash(29): note: No user-defined-conversion operator available that can perform this conversion, or the operator cannot be called
# 
# ppf_registration.h
# template <typename PointSource, typename PointTarget>
# class PPFRegistration : public Registration<PointSource, PointTarget>
# cdef extern from "pcl/registration/ppf_registration.h" namespace "pcl" nogil:
#     cdef cppclass PPFRegistration[Source, Target](Registration[Source, Target]):
#         PPFRegistration() except +
        # public:
        # cdef struct PoseWithVotes
        #   PoseWithVotes(Eigen::Affine3f &a_pose, unsigned int &a_votes)
        #   Eigen::Affine3f pose;
        #   unsigned int votes;
        # ctypedef std::vector<PoseWithVotes, Eigen::aligned_allocator<PoseWithVotes> > PoseWithVotesList;
        # /// input_ is the model cloud
        # using Registration<PointSource, PointTarget>::input_;
        # /// target_ is the scene cloud
        # using Registration<PointSource, PointTarget>::target_;
        # using Registration<PointSource, PointTarget>::converged_;
        # using Registration<PointSource, PointTarget>::final_transformation_;
        # using Registration<PointSource, PointTarget>::transformation_;
        # ctypedef pcl::PointCloud<PointSource> PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef pcl::PointCloud<PointTarget> PointCloudTarget;
        # ctypedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
        # ctypedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
        # /** \brief Method for setting the position difference clustering parameter
        #    * \param clustering_position_diff_threshold distance threshold below which two poses are
        #  * considered close enough to be in the same cluster (for the clustering phase of the algorithm)
        #  */
        #   inline void
        # setPositionClusteringThreshold (float clustering_position_diff_threshold)
        # /** \brief Returns the parameter defining the position difference clustering parameter -
        #  * distance threshold below which two poses are considered close enough to be in the same cluster
        #    * (for the clustering phase of the algorithm)
        #  */
        # inline float
        # getPositionClusteringThreshold ()
        # /** \brief Method for setting the rotation clustering parameter
        #  * \param clustering_rotation_diff_threshold rotation difference threshold below which two
        #  * poses are considered to be in the same cluster (for the clustering phase of the algorithm)
        #  */
        # inline void
        # setRotationClusteringThreshold (float clustering_rotation_diff_threshold)
        # /** \brief Returns the parameter defining the rotation clustering threshold
        #  */
        # inline float
        # getRotationClusteringThreshold ()
        # /** \brief Method for setting the scene reference point sampling rate
        #  * \param scene_reference_point_sampling_rate sampling rate for the scene reference point
        #  */
        # inline void setSceneReferencePointSamplingRate (unsigned int scene_reference_point_sampling_rate) { scene_reference_point_sampling_rate_ = scene_reference_point_sampling_rate; }
        # /** \brief Returns the parameter for the scene reference point sampling rate of the algorithm */
        # inline unsigned int
        # getSceneReferencePointSamplingRate ()
        # /** \brief Function that sets the search method for the algorithm
        #  * \note Right now, the only available method is the one initially proposed by
        #  * the authors - by using a hash map with discretized feature vectors
        #  * \param search_method smart pointer to the search method to be set
        #  */
        # inline void setSearchMethod (PPFHashMapSearch::Ptr search_method)
        # /** \brief Getter function for the search method of the class */
        # inline PPFHashMapSearch::Ptr getSearchMethod ()
        # /** \brief Provide a pointer to the input target (e.g., the point cloud that we want to align the input source to)
        #  * \param cloud the input point cloud target
        #  */
        # void setInputTarget (const PointCloudTargetConstPtr &cloud);

###

# pyramid_feature_matching.h
# template <typename PointFeature>
# class PyramidFeatureHistogram : public PCLBase<PointFeature>
# cdef cppclass PyramidFeatureHistogram[PointFeature](PCLBase[PointFeature]):
cdef extern from "pcl/registration/pyramid_feature_matching.h" namespace "pcl" nogil:
    cdef cppclass PyramidFeatureHistogram[PointFeature]:
        PyramidFeatureHistogram() except +
        # public:
        # using PCLBase<PointFeature>::input_;
        # ctypedef boost::shared_ptr<PyramidFeatureHistogram<PointFeature> > Ptr;
        # ctypedef Ptr PyramidFeatureHistogramPtr;
        # ctypedef boost::shared_ptr<const pcl::PointRepresentation<PointFeature> > FeatureRepresentationConstPtr;
        # /** \brief Method for setting the input dimension range parameter.
        #  * \note Please check the PyramidHistogram class description for more details about this parameter.
        #  */
        # inline void setInputDimensionRange (std::vector<std::pair<float, float> > &dimension_range_input)
        # /** \brief Method for retrieving the input dimension range vector */
        # inline std::vector<std::pair<float, float> > getInputDimensionRange () { return dimension_range_input_; }
        # /** \brief Method to set the target dimension range parameter.
        #  * \note Please check the PyramidHistogram class description for more details about this parameter.
        #  */
        # inline void
        # setTargetDimensionRange (std::vector<std::pair<float, float> > &dimension_range_target)
        # /** \brief Method for retrieving the target dimension range vector */
        # inline std::vector<std::pair<float, float> >
        # getTargetDimensionRange () { return dimension_range_target_; }
        # /** \brief Provide a pointer to the feature representation to use to convert features to k-D vectors.
        #  * \param feature_representation the const boost shared pointer to a PointRepresentation
        #  */
        # inline void
        # setPointRepresentation (const FeatureRepresentationConstPtr& feature_representation) { feature_representation_ = feature_representation; }
        # /** \brief Get a pointer to the feature representation used when converting features into k-D vectors. */
        # inline FeatureRepresentationConstPtr const
        # getPointRepresentation () { return feature_representation_; }
        # /** \brief The central method for inserting the feature set inside the pyramid and obtaining the complete pyramid */
        # void
        # compute ();
        # /** \brief Checks whether the pyramid histogram has been computed */
        # inline bool
        # isComputed () { return is_computed_; }
        # /** \brief Static method for comparing two pyramid histograms that returns a floating point value between 0 and 1,
        #  * representing the similiarity between the feature sets on which the two pyramid histograms are based.
        #  * \param pyramid_a Pointer to the first pyramid to be compared (needs to be computed already).
        #  * \param pyramid_b Pointer to the second pyramid to be compared (needs to be computed already).
        #  */
        # static float
        # comparePyramidFeatureHistograms (const PyramidFeatureHistogramPtr &pyramid_a,
        #                                  const PyramidFeatureHistogramPtr &pyramid_b);

###

# sample_consensus_prerejective.h
# namespace pcl
# {
#   /** \brief Pose estimation and alignment class using a prerejective RANSAC routine.
#    * 
#    * This class inserts a simple, yet effective "prerejection" step into the standard
#    * RANSAC pose estimation loop in order to avoid verification of pose hypotheses
#    * that are likely to be wrong. This is achieved by local pose-invariant geometric
#    * constraints, as also implemented in the class
#    * \ref registration::CorrespondenceRejectorPoly "CorrespondenceRejectorPoly".
#    * 
#    * In order to robustly align partial/occluded models, this routine performs
#    * fit error evaluation using only inliers, i.e. points closer than a
#    * Euclidean threshold, which is specifiable using \ref setInlierFraction().
#    * 
#    * The amount of prerejection or "greedyness" of the algorithm can be specified
#    * using \ref setSimilarityThreshold() in [0,1[, where a value of 0 means disabled,
#    * and 1 is maximally rejective.
#    * 
#    * If you use this in academic work, please cite:
#    * 
#    * A. G. Buch, D. Kraft, J.-K. Kamarainen, H. G. Petersen and N. Kruger.
#    * Pose Estimation using Local Structure-Specific Shape and Appearance Context.
#    * International Conference on Robotics and Automation (ICRA), 2013.
#    *  
#    * \author Anders Glent Buch (andersgb1@gmail.com)
#    * \ingroup registration
#    */
#   template <typename PointSource, typename PointTarget, typename FeatureT>
#   class SampleConsensusPrerejective : public Registration<PointSource, PointTarget>
#   {
#     public:
#       typedef typename Registration<PointSource, PointTarget>::Matrix4 Matrix4;
#       
#       using Registration<PointSource, PointTarget>::reg_name_;
#       using Registration<PointSource, PointTarget>::getClassName;
#       using Registration<PointSource, PointTarget>::input_;
#       using Registration<PointSource, PointTarget>::target_;
#       using Registration<PointSource, PointTarget>::tree_;
#       using Registration<PointSource, PointTarget>::max_iterations_;
#       using Registration<PointSource, PointTarget>::corr_dist_threshold_;
#       using Registration<PointSource, PointTarget>::transformation_;
#       using Registration<PointSource, PointTarget>::final_transformation_;
#       using Registration<PointSource, PointTarget>::transformation_estimation_;
#       using Registration<PointSource, PointTarget>::getFitnessScore;
#       using Registration<PointSource, PointTarget>::converged_;
# 
#       typedef typename Registration<PointSource, PointTarget>::PointCloudSource PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#       typedef typename Registration<PointSource, PointTarget>::PointCloudTarget PointCloudTarget;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       typedef pcl::PointCloud<FeatureT> FeatureCloud;
#       typedef typename FeatureCloud::Ptr FeatureCloudPtr;
#       typedef typename FeatureCloud::ConstPtr FeatureCloudConstPtr;
# 
#       typedef boost::shared_ptr<SampleConsensusPrerejective<PointSource, PointTarget, FeatureT> > Ptr;
#       typedef boost::shared_ptr<const SampleConsensusPrerejective<PointSource, PointTarget, FeatureT> > ConstPtr;
# 
#       typedef typename KdTreeFLANN<FeatureT>::Ptr FeatureKdTreePtr;
#       
#       typedef pcl::registration::CorrespondenceRejectorPoly<PointSource, PointTarget> CorrespondenceRejectorPoly;
#       typedef typename CorrespondenceRejectorPoly::Ptr CorrespondenceRejectorPolyPtr;
#       typedef typename CorrespondenceRejectorPoly::ConstPtr CorrespondenceRejectorPolyConstPtr;
#       
#       /** \brief Constructor */
#       SampleConsensusPrerejective ()
#         : input_features_ ()
#         , target_features_ ()
#         , nr_samples_(3)
#         , k_correspondences_ (2)
#         , feature_tree_ (new pcl::KdTreeFLANN<FeatureT>)
#         , correspondence_rejector_poly_ (new CorrespondenceRejectorPoly)
#         , inlier_fraction_ (0.0f)
#       {
#         reg_name_ = "SampleConsensusPrerejective";
#         correspondence_rejector_poly_->setSimilarityThreshold (0.6f);
#         max_iterations_ = 5000;
#         transformation_estimation_.reset (new pcl::registration::TransformationEstimationSVD<PointSource, PointTarget>);
#       };
#       
#       /** \brief Destructor */
#       virtual ~SampleConsensusPrerejective ()
#       {
#       }
# 
#       /** \brief Provide a boost shared pointer to the source point cloud's feature descriptors
#         * \param features the source point cloud's features
#         */
#       void 
#       setSourceFeatures (const FeatureCloudConstPtr &features);
# 
#       /** \brief Get a pointer to the source point cloud's features */
#       inline const FeatureCloudConstPtr
#       getSourceFeatures () const
#       { 
#         return (input_features_);
#       }
# 
#       /** \brief Provide a boost shared pointer to the target point cloud's feature descriptors
#         * \param features the target point cloud's features
#         */
#       void 
#       setTargetFeatures (const FeatureCloudConstPtr &features);
# 
#       /** \brief Get a pointer to the target point cloud's features */
#       inline const FeatureCloudConstPtr 
#       getTargetFeatures () const
#       {
#         return (target_features_);
#       }
# 
#       /** \brief Set the number of samples to use during each iteration
#         * \param nr_samples the number of samples to use during each iteration
#         */
#       inline void 
#       setNumberOfSamples (int nr_samples)
#       {
#         nr_samples_ = nr_samples;
#       }
# 
#       /** \brief Get the number of samples to use during each iteration, as set by the user */
#       inline int 
#       getNumberOfSamples () const
#       {
#         return (nr_samples_);
#       }
# 
#       /** \brief Set the number of neighbors to use when selecting a random feature correspondence.  A higher value will
#         * add more randomness to the feature matching.
#         * \param k the number of neighbors to use when selecting a random feature correspondence.
#         */
#       inline void
#       setCorrespondenceRandomness (int k)
#       {
#         k_correspondences_ = k;
#       }
# 
#       /** \brief Get the number of neighbors used when selecting a random feature correspondence, as set by the user */
#       inline int
#       getCorrespondenceRandomness () const
#       {
#         return (k_correspondences_);
#       }
#       
#       /** \brief Set the similarity threshold in [0,1[ between edge lengths of the underlying polygonal correspondence rejector object,
#        * where 1 is a perfect match
#        * \param similarity_threshold edge length similarity threshold
#        */
#       inline void
#       setSimilarityThreshold (float similarity_threshold)
#       {
#         correspondence_rejector_poly_->setSimilarityThreshold (similarity_threshold);
#       }
#       
#       /** \brief Get the similarity threshold between edge lengths of the underlying polygonal correspondence rejector object,
#        * \return edge length similarity threshold
#        */
#       inline float
#       getSimilarityThreshold () const
#       {
#         return correspondence_rejector_poly_->getSimilarityThreshold ();
#       }
#       
#       /** \brief Set the required inlier fraction (of the input)
#        * \param inlier_fraction required inlier fraction, must be in [0,1]
#        */
#       inline void
#       setInlierFraction (float inlier_fraction)
#       {
#         inlier_fraction_ = inlier_fraction;
#       }
#       
#       /** \brief Get the required inlier fraction
#        * \return required inlier fraction in [0,1]
#        */
#       inline float
#       getInlierFraction () const
#       {
#         return inlier_fraction_;
#       }
#       
#       /** \brief Get the inlier indices of the source point cloud under the final transformation
#        * @return inlier indices
#        */
#       inline const std::vector<int>&
#       getInliers () const
#       {
#         return inliers_;
#       }
# 
#     protected:
#       /** \brief Choose a random index between 0 and n-1
#         * \param n the number of possible indices to choose from
#         */
#       inline int 
#       getRandomIndex (int n) const
#       {
#         return (static_cast<int> (n * (rand () / (RAND_MAX + 1.0))));
#       };
#       
#       /** \brief Select \a nr_samples sample points from cloud while making sure that their pairwise distances are 
#         * greater than a user-defined minimum distance, \a min_sample_distance.
#         * \param cloud the input point cloud
#         * \param nr_samples the number of samples to select
#         * \param sample_indices the resulting sample indices
#         */
#       void 
#       selectSamples (const PointCloudSource &cloud, int nr_samples, std::vector<int> &sample_indices);
# 
#       /** \brief For each of the sample points, find a list of points in the target cloud whose features are similar to 
#         * the sample points' features. From these, select one randomly which will be considered that sample point's 
#         * correspondence.
#         * \param sample_indices the indices of each sample point
#         * \param similar_features correspondence cache, which is used to read/write already computed correspondences
#         * \param corresponding_indices the resulting indices of each sample's corresponding point in the target cloud
#         */
#       void 
#       findSimilarFeatures (const std::vector<int> &sample_indices,
#               std::vector<std::vector<int> >& similar_features,
#               std::vector<int> &corresponding_indices);
# 
#       /** \brief Rigid transformation computation method.
#         * \param output the transformed input point cloud dataset using the rigid transformation found
#         * \param guess The computed transformation
#         */
#       void 
#       computeTransformation (PointCloudSource &output, const Eigen::Matrix4f& guess);
# 
#       /** \brief Obtain the fitness of a transformation
#         * The following metrics are calculated, based on
#         * \b final_transformation_ and \b corr_dist_threshold_:
#         *   - Inliers: the number of transformed points which are closer than threshold to NN
#         *   - Error score: the MSE of the inliers  
#         * \param inliers indices of source point cloud inliers
#         * \param fitness_score output fitness score as RMSE 
#         */
#       void 
#       getFitness (std::vector<int>& inliers, float& fitness_score);
# 
#       /** \brief The source point cloud's feature descriptors. */
#       FeatureCloudConstPtr input_features_;
# 
#       /** \brief The target point cloud's feature descriptors. */
#       FeatureCloudConstPtr target_features_;  
# 
#       /** \brief The number of samples to use during each iteration. */
#       int nr_samples_;
# 
#       /** \brief The number of neighbors to use when selecting a random feature correspondence. */
#       int k_correspondences_;
#      
#       /** \brief The KdTree used to compare feature descriptors. */
#       FeatureKdTreePtr feature_tree_;
#       
#       /** \brief The polygonal correspondence rejector used for prerejection */
#       CorrespondenceRejectorPolyPtr correspondence_rejector_poly_;
#       
#       /** \brief The fraction [0,1] of inlier points required for accepting a transformation */
#       float inlier_fraction_;
#       
#       /** \brief Inlier points of final transformation as indices into source */
#       std::vector<int> inliers_;
#   };
# 
###

# transformation_estimation.h
# template <typename PointSource, typename PointTarget>
# class TransformationEstimation
cdef extern from "pcl/registration/transformation_estimation.h" namespace "pcl" nogil:
    cdef cppclass TransformationEstimation[Source, Target](Registration[Source, Target]):
        TransformationEstimation() except +
        # public:
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # virtual void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix) = 0;
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # virtual void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix) = 0;
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # virtual void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const std::vector<int> &indices_tgt,
        #     Eigen::Matrix4f &transformation_matrix) = 0;
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] correspondences the vector of correspondences between source and target point cloud
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # virtual void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const pcl::Correspondences &correspondences,
        #     Eigen::Matrix4f &transformation_matrix) = 0;

# ctypedef shared_ptr[TransformationEstimation<PointSource, PointTarget> > Ptr;
# ctypedef shared_ptr[const TransformationEstimation<PointSource, PointTarget> > ConstPtr;

###

# transformation_estimation_2D.h
# namespace pcl
# {
#   namespace registration
#   {
#     /** @b TransformationEstimation2D implements a simple 2D rigid transformation 
#       * estimation (x, y, theta) for a given pair of datasets. 
#       *
#       * The two datasets should already be transformed so that the reference plane 
#       * equals z = 0.
#       *
#       * \note The class is templated on the source and target point types as well as on the output scalar of the transformation matrix (i.e., float or double). Default: float.
#       *
#       * \author Suat Gedikli
#       * \ingroup registration
#       */
#     template <typename PointSource, typename PointTarget, typename Scalar = float>
#     class TransformationEstimation2D : public TransformationEstimation<PointSource, PointTarget, Scalar>
#     {
#       public:
#         typedef boost::shared_ptr<TransformationEstimation2D<PointSource, PointTarget, Scalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimation2D<PointSource, PointTarget, Scalar> > ConstPtr;
# 
#         typedef typename TransformationEstimation<PointSource, PointTarget, Scalar>::Matrix4 Matrix4;
# 
#         TransformationEstimation2D () {};
#         virtual ~TransformationEstimation2D () {};
# 
#         /** \brief Estimate a rigid transformation between a source and a target point cloud in 2D.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid transformation between a source and a target point cloud in 2D.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid transformation between a source and a target point cloud in 2D.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         virtual void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const std::vector<int> &indices_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid transformation between a source and a target point cloud in 2D.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] correspondences the vector of correspondences between source and target point cloud
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         virtual void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const pcl::Correspondences &correspondences,
#             Matrix4 &transformation_matrix) const;
# 
#       protected:
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target
#           * \param[in] source_it an iterator over the source point cloud dataset
#           * \param[in] target_it an iterator over the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         void
#         estimateRigidTransformation (ConstCloudIterator<PointSource>& source_it,
#                                      ConstCloudIterator<PointTarget>& target_it,
#                                      Matrix4 &transformation_matrix) const;
# 
#         /** \brief Obtain a 4x4 rigid transformation matrix from a correlation matrix H = src * tgt'
#           * \param[in] cloud_src_demean the input source cloud, demeaned, in Eigen format
#           * \param[in] centroid_src the input source centroid, in Eigen format
#           * \param[in] cloud_tgt_demean the input target cloud, demeaned, in Eigen format
#           * \param[in] centroid_tgt the input target cloud, in Eigen format
#           * \param[out] transformation_matrix the resultant 4x4 rigid transformation matrix
#           */ 
#         void
#         getTransformationFromCorrelation (
#             const Eigen::Matrix<Scalar, Eigen::Dynamic, Eigen::Dynamic> &cloud_src_demean,
#             const Eigen::Matrix<Scalar, 4, 1> &centroid_src,
#             const Eigen::Matrix<Scalar, Eigen::Dynamic, Eigen::Dynamic> &cloud_tgt_demean,
#             const Eigen::Matrix<Scalar, 4, 1> &centroid_tgt,
#             Matrix4 &transformation_matrix) const;
#     };
###

# transformation_estimation_dual_quaternion.h
# namespace pcl
# {
#   namespace registration
#   {
#     /** @b TransformationEstimationDualQuaternion implements dual quaternion based estimation of
#       * the transformation aligning the given correspondences.
#       *
#       * \note The class is templated on the source and target point types as well as on the output scalar of the transformation matrix (i.e., float or double). Default: float.
#       * \author Sergey Zagoruyko
#       * \ingroup registration
#       */
#     template <typename PointSource, typename PointTarget, typename Scalar = float>
#     class TransformationEstimationDualQuaternion : public TransformationEstimation<PointSource, PointTarget, Scalar>
#     {
#       public:
#         typedef boost::shared_ptr<TransformationEstimationDualQuaternion<PointSource, PointTarget, Scalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimationDualQuaternion<PointSource, PointTarget, Scalar> > ConstPtr;
# 
#         typedef typename TransformationEstimation<PointSource, PointTarget, Scalar>::Matrix4 Matrix4;
# 
#         TransformationEstimationDualQuaternion () {};
#         virtual ~TransformationEstimationDualQuaternion () {};
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using
#           * dual quaternion optimization
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using
#           * dual quaternion optimization
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using
#           * dual quaternion optimization
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const std::vector<int> &indices_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using
#           * dual quaternion optimization
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] correspondences the vector of correspondences between source and target point cloud
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const pcl::Correspondences &correspondences,
#             Matrix4 &transformation_matrix) const;
# 
#       protected:
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target
#           * \param[in] source_it an iterator over the source point cloud dataset
#           * \param[in] target_it an iterator over the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         void
#         estimateRigidTransformation (ConstCloudIterator<PointSource>& source_it,
#                                      ConstCloudIterator<PointTarget>& target_it,
#                                      Matrix4 &transformation_matrix) const;
#      };
###

# transformation_estimation_lm.h
# template <typename PointSource, typename PointTarget, typename MatScalar = float>
# class TransformationEstimationLM : public TransformationEstimation<PointSource, PointTarget, MatScalar>
cdef extern from "pcl/registration/transformation_estimation_lm.h" namespace "pcl" nogil:
    cdef cppclass TransformationEstimationLM[Source, Target](TransformationEstimation[Source, Target]):
        TransformationEstimationLM() except +
#       typedef pcl::PointCloud<PointSource> PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#       typedef pcl::PointCloud<PointTarget> PointCloudTarget;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       public:
#         typedef boost::shared_ptr<TransformationEstimationLM<PointSource, PointTarget, MatScalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimationLM<PointSource, PointTarget, MatScalar> > ConstPtr;
# 
#         typedef Eigen::Matrix<MatScalar, Eigen::Dynamic, 1> VectorX;
#         typedef Eigen::Matrix<MatScalar, 4, 1> Vector4;
#         typedef typename TransformationEstimation<PointSource, PointTarget, MatScalar>::Matrix4 Matrix4;
#         
#         /** \brief Constructor. */
#         TransformationEstimationLM ();
# 
#         /** \brief Copy constructor. 
#           * \param[in] src the TransformationEstimationLM object to copy into this 
#           */
#         TransformationEstimationLM (const TransformationEstimationLM &src) : 
#           tmp_src_ (src.tmp_src_), 
#           tmp_tgt_ (src.tmp_tgt_), 
#           tmp_idx_src_ (src.tmp_idx_src_), 
#           tmp_idx_tgt_ (src.tmp_idx_tgt_), 
#           warp_point_ (src.warp_point_)
#         {};
# 
#         /** \brief Copy operator. 
#           * \param[in] src the TransformationEstimationLM object to copy into this 
#           */
#         TransformationEstimationLM&
#         operator = (const TransformationEstimationLM &src)
#         {
#           tmp_src_ = src.tmp_src_; 
#           tmp_tgt_ = src.tmp_tgt_; 
#           tmp_idx_src_ = src.tmp_idx_src_;
#           tmp_idx_tgt_ = src.tmp_idx_tgt_; 
#           warp_point_ = src.warp_point_;
#         }
# 
#          /** \brief Destructor. */
#         virtual ~TransformationEstimationLM () {};
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from 
#           * \a indices_src
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const std::vector<int> &indices_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] correspondences the vector of correspondences between source and target point cloud
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const pcl::Correspondences &correspondences,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Set the function we use to warp points. Defaults to rigid 6D warp.
#           * \param[in] warp_fcn a shared pointer to an object that warps points
#           */
#         void
#         setWarpFunction (const boost::shared_ptr<WarpPointRigid<PointSource, PointTarget, MatScalar> > &warp_fcn)
#         {
#           warp_point_ = warp_fcn;
#         }
# 
#       protected:
#         /** \brief Compute the distance between a source point and its corresponding target point
#           * \param[in] p_src The source point
#           * \param[in] p_tgt The target point
#           * \return The distance between \a p_src and \a p_tgt
#           *
#           * \note Older versions of PCL used this method internally for calculating the
#           * optimization gradient. Since PCL 1.7, a switch has been made to the 
#           * computeDistance method using Vector4 types instead. This method is only 
#           * kept for API compatibility reasons.
#           */
#         virtual MatScalar
#         computeDistance (const PointSource &p_src, const PointTarget &p_tgt) const
#         {
#           Vector4 s (p_src.x, p_src.y, p_src.z, 0);
#           Vector4 t (p_tgt.x, p_tgt.y, p_tgt.z, 0);
#           return ((s - t).norm ());
#         }
# 
#         /** \brief Compute the distance between a source point and its corresponding target point
#           * \param[in] p_src The source point
#           * \param[in] p_tgt The target point
#           * \return The distance between \a p_src and \a p_tgt
#           *
#           * \note A different distance function can be defined by creating a subclass of 
#           * TransformationEstimationLM and overriding this method. 
#           * (See \a TransformationEstimationPointToPlane)
#           */
#         virtual MatScalar
#         computeDistance (const Vector4 &p_src, const PointTarget &p_tgt) const
#         {
#           Vector4 t (p_tgt.x, p_tgt.y, p_tgt.z, 0);
#           return ((p_src - t).norm ());
#         }
# 
#         /** \brief Temporary pointer to the source dataset. */
#         mutable const PointCloudSource *tmp_src_;
# 
#         /** \brief Temporary pointer to the target dataset. */
#         mutable const PointCloudTarget  *tmp_tgt_;
# 
#         /** \brief Temporary pointer to the source dataset indices. */
#         mutable const std::vector<int> *tmp_idx_src_;
# 
#         /** \brief Temporary pointer to the target dataset indices. */
#         mutable const std::vector<int> *tmp_idx_tgt_;
# 
#         /** \brief The parameterized function used to warp the source to the target. */
#         boost::shared_ptr<pcl::registration::WarpPointRigid<PointSource, PointTarget, MatScalar> > warp_point_;
#         
#         /** Base functor all the models that need non linear optimization must
#           * define their own one and implement operator() (const Eigen::VectorXd& x, Eigen::VectorXd& fvec)
#           * or operator() (const Eigen::VectorXf& x, Eigen::VectorXf& fvec) dependening on the choosen _Scalar
#           */
#         template<typename _Scalar, int NX=Eigen::Dynamic, int NY=Eigen::Dynamic>
#         struct Functor
#         {
#           typedef _Scalar Scalar;
#           enum 
#           {
#             InputsAtCompileTime = NX,
#             ValuesAtCompileTime = NY
#           };
#           typedef Eigen::Matrix<_Scalar,InputsAtCompileTime,1> InputType;
#           typedef Eigen::Matrix<_Scalar,ValuesAtCompileTime,1> ValueType;
#           typedef Eigen::Matrix<_Scalar,ValuesAtCompileTime,InputsAtCompileTime> JacobianType;
# 
#           /** \brief Empty Construtor. */
#           Functor () : m_data_points_ (ValuesAtCompileTime) {}
# 
#           /** \brief Constructor
#             * \param[in] m_data_points number of data points to evaluate.
#             */
#           Functor (int m_data_points) : m_data_points_ (m_data_points) {}
#         
#           /** \brief Destructor. */
#           virtual ~Functor () {}
# 
#           /** \brief Get the number of values. */ 
#           int
#           values () const { return (m_data_points_); }
# 
#           protected:
#             int m_data_points_;
#         };
# 
#         struct OptimizationFunctor : public Functor<MatScalar>
#         {
#           using Functor<MatScalar>::values;
# 
#           /** Functor constructor
#             * \param[in] m_data_points the number of data points to evaluate
#             * \param[in,out] estimator pointer to the estimator object
#             */
#           OptimizationFunctor (int m_data_points, 
#                                const TransformationEstimationLM *estimator) 
#             :  Functor<MatScalar> (m_data_points), estimator_ (estimator) 
#           {}
# 
#           /** Copy constructor
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctor (const OptimizationFunctor &src) : 
#             Functor<MatScalar> (src.m_data_points_), estimator_ ()
#           {
#             *this = src;
#           }
# 
#           /** Copy operator
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctor& 
#           operator = (const OptimizationFunctor &src) 
#           { 
#             Functor<MatScalar>::operator=(src);
#             estimator_ = src.estimator_; 
#             return (*this); 
#           }
# 
#           /** \brief Destructor. */
#           virtual ~OptimizationFunctor () {}
# 
#           /** Fill fvec from x. For the current state vector x fill the f values
#             * \param[in] x state vector
#             * \param[out] fvec f values vector
#             */
#           int 
#           operator () (const VectorX &x, VectorX &fvec) const;
# 
#           const TransformationEstimationLM<PointSource, PointTarget, MatScalar> *estimator_;
#         };
# 
#         struct OptimizationFunctorWithIndices : public Functor<MatScalar>
#         {
#           using Functor<MatScalar>::values;
# 
#           /** Functor constructor
#             * \param[in] m_data_points the number of data points to evaluate
#             * \param[in,out] estimator pointer to the estimator object
#             */
#           OptimizationFunctorWithIndices (int m_data_points, 
#                                           const TransformationEstimationLM *estimator) 
#             : Functor<MatScalar> (m_data_points), estimator_ (estimator) 
#           {}
# 
#           /** Copy constructor
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctorWithIndices (const OptimizationFunctorWithIndices &src)
#             : Functor<MatScalar> (src.m_data_points_), estimator_ ()
#           {
#             *this = src;
#           }
# 
#           /** Copy operator
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctorWithIndices& 
#           operator = (const OptimizationFunctorWithIndices &src) 
#           { 
#             Functor<MatScalar>::operator=(src);
#             estimator_ = src.estimator_; 
#             return (*this); 
#           }
# 
#           /** \brief Destructor. */
#           virtual ~OptimizationFunctorWithIndices () {}
# 
#           /** Fill fvec from x. For the current state vector x fill the f values
#             * \param[in] x state vector
#             * \param[out] fvec f values vector
#             */
#           int 
#           operator () (const VectorX &x, VectorX &fvec) const;
# 
#           const TransformationEstimationLM<PointSource, PointTarget, MatScalar> *estimator_;
#         };
#       public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#     };
###

# Ver 1.6.0
# template <typename PointSource, typename PointTarget>
# class TransformationEstimationLM : public TransformationEstimation<PointSource, PointTarget>
        # ctypedef pcl::PointCloud<PointSource> PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef pcl::PointCloud<PointTarget> PointCloudTarget;
        # ctypedef PointIndices::Ptr PointIndicesPtr;
        # ctypedef PointIndices::ConstPtr PointIndicesConstPtr;
        # public:
        # TransformationEstimationLM (const TransformationEstimationLM &src)
        # TransformationEstimationLM& operator = (const TransformationEstimationLM &src)
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from 
        #   * \a indices_src
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const std::vector<int> &indices_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] correspondences the vector of correspondences between source and target point cloud
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const pcl::Correspondences &correspondences,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Set the function we use to warp points. Defaults to rigid 6D warp.
        #   * \param[in] warp_fcn a shared pointer to an object that warps points
        #   */
        # void
        # setWarpFunction (const boost::shared_ptr<WarpPointRigid<PointSource, PointTarget> > &warp_fcn)
        # /** Base functor all the models that need non linear optimization must
        #   * define their own one and implement operator() (const Eigen::VectorXd& x, Eigen::VectorXd& fvec)
        #   * or operator() (const Eigen::VectorXf& x, Eigen::VectorXf& fvec) dependening on the choosen _Scalar
        #   */
        # template<typename _Scalar, int NX=Eigen::Dynamic, int NY=Eigen::Dynamic>
        # struct Functor
        # {
        #   typedef _Scalar Scalar;
        #   enum 
        #   {
        #     InputsAtCompileTime = NX,
        #     ValuesAtCompileTime = NY
        #   };
        #   typedef Eigen::Matrix<Scalar,InputsAtCompileTime,1> InputType;
        #   typedef Eigen::Matrix<Scalar,ValuesAtCompileTime,1> ValueType;
        #   typedef Eigen::Matrix<Scalar,ValuesAtCompileTime,InputsAtCompileTime> JacobianType;
        # 
        #   /** \brief Empty Construtor. */
        #   Functor () : m_data_points_ (ValuesAtCompileTime) {}
        #   /** \brief Constructor
        #     * \param[in] m_data_points number of data points to evaluate.
        #     */
        #   Functor (int m_data_points) : m_data_points_ (m_data_points) {}
        # 
        #   /** \brief Destructor. */
        #   virtual ~Functor () {}
        # 
        #   /** \brief Get the number of values. */ 
        #   int
        #   values () const { return (m_data_points_); }
        # 
        #   protected:
        #     int m_data_points_;
        # };
        # struct OptimizationFunctor : public Functor<double>
        # {
        #   using Functor<double>::values;
        # /** Functor constructor
        #     * \param[in] m_data_points the number of data points to evaluate
        #     * \param[in,out] estimator pointer to the estimator object
        #     */
        #   OptimizationFunctor (int m_data_points, TransformationEstimationLM<PointSource, PointTarget> *estimator) : 
        #     Functor<double> (m_data_points), estimator_ (estimator) {}
        #   /** Copy constructor
        #     * \param[in] the optimization functor to copy into this
        #     */
        #   inline OptimizationFunctor (const OptimizationFunctor &src) : 
        #     Functor<double> (src.m_data_points_), estimator_ ()
        #   {
        #     *this = src;
        #   }
        #   /** Copy operator
        #     * \param[in] the optimization functor to copy into this
        #     */
        #   inline OptimizationFunctor& 
        #   operator = (const OptimizationFunctor &src) 
        #   { 
        #     Functor<double>::operator=(src);
        #     estimator_ = src.estimator_; 
        #     return (*this); 
        #   }
        #   /** \brief Destructor. */
        #   virtual ~OptimizationFunctor () {}
        #   /** Fill fvec from x. For the current state vector x fill the f values
        #     * \param[in] x state vector
        #     * \param[out] fvec f values vector
        #     */
        #   int 
        #   operator () (const Eigen::VectorXd &x, Eigen::VectorXd &fvec) const;
        # 
        #   TransformationEstimationLM<PointSource, PointTarget> *estimator_;
        # };
        # struct OptimizationFunctorWithIndices : public Functor<double>
        # {
        #   using Functor<double>::values;
        #   /** Functor constructor
        #     * \param[in] m_data_points the number of data points to evaluate
        #     * \param[in,out] estimator pointer to the estimator object
        #     */
        #   OptimizationFunctorWithIndices (int m_data_points, TransformationEstimationLM *estimator) :
        #     Functor<double> (m_data_points), estimator_ (estimator) {}
        #   /** Copy constructor
        #     * \param[in] the optimization functor to copy into this
        #     */
        #   inline OptimizationFunctorWithIndices (const OptimizationFunctorWithIndices &src) : 
        #     Functor<double> (src.m_data_points_), estimator_ ()
        #   {
        #     *this = src;
        #   }
        #   /** Copy operator
        #     * \param[in] the optimization functor to copy into this
        #     */
        #   inline OptimizationFunctorWithIndices& 
        #   operator = (const OptimizationFunctorWithIndices &src) 
        #   { 
        #     Functor<double>::operator=(src);
        #     estimator_ = src.estimator_; 
        #     return (*this); 
        #   }
        # 
        #   /** \brief Destructor. */
        #   virtual ~OptimizationFunctorWithIndices () {}
        # 
        #   /** Fill fvec from x. For the current state vector x fill the f values
        #     * \param[in] x state vector
        #     * \param[out] fvec f values vector
        #     */
        #   int 
        #   operator () (const Eigen::VectorXd &x, Eigen::VectorXd &fvec) const;
        #   TransformationEstimationLM<PointSource, PointTarget> *estimator_;
        # };
        # public:
        # EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

# transformation_estimation_point_to_plane.h
# template <typename PointSource, typename PointTarget>
# class TransformationEstimationPointToPlane : public TransformationEstimationLM<PointSource, PointTarget>
cdef extern from "pcl/registration/transformation_estimation_point_to_plane.h" namespace "pcl" nogil:
    cdef cppclass TransformationEstimationPointToPlane[Source, Target](TransformationEstimationLM[Source, Target]):
        TransformationEstimationPointToPlane ()
        # public:
        # ctypedef boost::shared_ptr<TransformationEstimationPointToPlane<PointSource, PointTarget> > Ptr;
        # ctypedef pcl::PointCloud<PointSource> PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef pcl::PointCloud<PointTarget> PointCloudTarget;
        # ctypedef PointIndices::Ptr PointIndicesPtr;
        # ctypedef PointIndices::ConstPtr PointIndicesConstPtr;
###

# transformation_estimation_point_to_plane_lls.h
# template <typename PointSource, typename PointTarget>
# class TransformationEstimationPointToPlaneLLS : public TransformationEstimation<PointSource, PointTarget>

cdef extern from "pcl/registration/transformation_estimation_point_to_plane_lls.h" namespace "pcl" nogil:
    cdef cppclass TransformationEstimationPointToPlaneLLS[Source, Target](TransformationEstimation[Source, Target]):
        TransformationEstimationPointToPlaneLLS ()
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const std::vector<int> &indices_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] correspondences the vector of correspondences between source and target point cloud
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const pcl::Correspondences &correspondences,
        #     Eigen::Matrix4f &transformation_matrix);

###

# transformation_estimation_point_to_plane_lls_weighted.h
# namespace pcl
#   namespace registration
#     /** \brief @b TransformationEstimationPointToPlaneLLSWeighted implements a Linear Least Squares (LLS) approximation
#       * for minimizing the point-to-plane distance between two clouds of corresponding points with normals, with the
#       * possibility of assigning weights to the correspondences.
#       *
#       * For additional details, see 
#       *   "Linear Least-Squares Optimization for Point-to-Plane ICP Surface Registration", Kok-Lim Low, 2004
#       *
#       * \note The class is templated on the source and target point types as well as on the output scalar of the
#       * transformation matrix (i.e., float or double). Default: float.
#       * \author Alex Ichim
#       * \ingroup registration
#       */
#     template <typename PointSource, typename PointTarget, typename Scalar = float>
#     class TransformationEstimationPointToPlaneLLSWeighted : public TransformationEstimation<PointSource, PointTarget, Scalar>
#     {
#       public:
#         typedef boost::shared_ptr<TransformationEstimationPointToPlaneLLSWeighted<PointSource, PointTarget, Scalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimationPointToPlaneLLSWeighted<PointSource, PointTarget, Scalar> > ConstPtr;
# 
#         typedef typename TransformationEstimation<PointSource, PointTarget, Scalar>::Matrix4 Matrix4;
#         
#         TransformationEstimationPointToPlaneLLSWeighted () { };
#         virtual ~TransformationEstimationPointToPlaneLLSWeighted () { };
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const std::vector<int> &indices_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] correspondences the vector of correspondences between source and target point cloud
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const pcl::Correspondences &correspondences,
#             Matrix4 &transformation_matrix) const;
# 
# 
#         /** \brief Set the weights for the correspondences.
#           * \param[in] weights the weights for each correspondence
#           */
#         inline void
#         setCorrespondenceWeights (const std::vector<Scalar> &weights)
#         { weights_ = weights; }
# 
#       protected:
#         
#         /** \brief Estimate a rigid rotation transformation between a source and a target
#           * \param[in] source_it an iterator over the source point cloud dataset
#           * \param[in] target_it an iterator over the target point cloud dataset
#           * \param weights_it
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         void 
#         estimateRigidTransformation (ConstCloudIterator<PointSource>& source_it, 
#                                      ConstCloudIterator<PointTarget>& target_it, 
#                                      typename std::vector<Scalar>::const_iterator& weights_it,
#                                      Matrix4 &transformation_matrix) const;
# 
#         /** \brief Construct a 4 by 4 tranformation matrix from the provided rotation and translation.
#           * \param[in] alpha the rotation about the x-axis
#           * \param[in] beta the rotation about the y-axis
#           * \param[in] gamma the rotation about the z-axis
#           * \param[in] tx the x translation
#           * \param[in] ty the y translation
#           * \param[in] tz the z translation
#           * \param[out] transformation_matrix the resultant transformation matrix
#           */
#         inline void
#         constructTransformationMatrix (const double & alpha, const double & beta, const double & gamma,
#                                        const double & tx,    const double & ty,   const double & tz,
#                                        Matrix4 &transformation_matrix) const;
# 
#         std::vector<Scalar> weights_;
#     };
# 
###

# transformation_estimation_point_to_plane_weighted.h
# namespace pcl
# namespace registration
# template <typename PointSource, typename PointTarget, typename MatScalar = float>
# class TransformationEstimationPointToPlaneWeighted : public TransformationEstimationPointToPlane<PointSource, PointTarget, MatScalar>
#     {
#       typedef pcl::PointCloud<PointSource> PointCloudSource;
#       typedef typename PointCloudSource::Ptr PointCloudSourcePtr;
#       typedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
# 
#       typedef pcl::PointCloud<PointTarget> PointCloudTarget;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       public:
#         typedef boost::shared_ptr<TransformationEstimationPointToPlaneWeighted<PointSource, PointTarget, MatScalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimationPointToPlaneWeighted<PointSource, PointTarget, MatScalar> > ConstPtr;
# 
#         typedef Eigen::Matrix<MatScalar, Eigen::Dynamic, 1> VectorX;
#         typedef Eigen::Matrix<MatScalar, 4, 1> Vector4;
#         typedef typename TransformationEstimation<PointSource, PointTarget, MatScalar>::Matrix4 Matrix4;
#         
#         /** \brief Constructor. */
#         TransformationEstimationPointToPlaneWeighted ();
# 
#         /** \brief Copy constructor. 
#           * \param[in] src the TransformationEstimationPointToPlaneWeighted object to copy into this
#           */
#         TransformationEstimationPointToPlaneWeighted (const TransformationEstimationPointToPlaneWeighted &src) :
#           tmp_src_ (src.tmp_src_), 
#           tmp_tgt_ (src.tmp_tgt_), 
#           tmp_idx_src_ (src.tmp_idx_src_), 
#           tmp_idx_tgt_ (src.tmp_idx_tgt_), 
#           warp_point_ (src.warp_point_),
#           correspondence_weights_ (src.correspondence_weights_),
#           use_correspondence_weights_ (src.use_correspondence_weights_)
#         {};
# 
#         /** \brief Copy operator. 
#           * \param[in] src the TransformationEstimationPointToPlaneWeighted object to copy into this
#           */
#         TransformationEstimationPointToPlaneWeighted&
#         operator = (const TransformationEstimationPointToPlaneWeighted &src)
#         {
#           tmp_src_ = src.tmp_src_; 
#           tmp_tgt_ = src.tmp_tgt_; 
#           tmp_idx_src_ = src.tmp_idx_src_;
#           tmp_idx_tgt_ = src.tmp_idx_tgt_; 
#           warp_point_ = src.warp_point_;
#           correspondence_weights_ = src.correspondence_weights_;
#           use_correspondence_weights_ = src.use_correspondence_weights_;
#         }
# 
#          /** \brief Destructor. */
#         virtual ~TransformationEstimationPointToPlaneWeighted () {};
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           * \note Uses the weights given by setWeights.
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[out] transformation_matrix the resultant transformation matrix
#           * \note Uses the weights given by setWeights.
#           */
#         inline void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from 
#           * \a indices_src
#           * \param[out] transformation_matrix the resultant transformation matrix
#           * \note Uses the weights given by setWeights.
#           */
#         void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const std::vector<int> &indices_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const std::vector<int> &indices_tgt,
#             Matrix4 &transformation_matrix) const;
# 
#         /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using LM.
#           * \param[in] cloud_src the source point cloud dataset
#           * \param[in] cloud_tgt the target point cloud dataset
#           * \param[in] correspondences the vector of correspondences between source and target point cloud
#           * \param[out] transformation_matrix the resultant transformation matrix
#           * \note Uses the weights given by setWeights.
#           */
#         void
#         estimateRigidTransformation (
#             const pcl::PointCloud<PointSource> &cloud_src,
#             const pcl::PointCloud<PointTarget> &cloud_tgt,
#             const pcl::Correspondences &correspondences,
#             Matrix4 &transformation_matrix) const;  
# 
# 
#         inline void
#         setWeights (const std::vector<double> &weights)
#         { correspondence_weights_ = weights; }
# 
#         /// use the weights given in the pcl::CorrespondencesPtr for one of the estimateTransformation (...) methods
#         inline void
#         setUseCorrespondenceWeights (bool use_correspondence_weights)
#         { use_correspondence_weights_ = use_correspondence_weights; }
# 
#         /** \brief Set the function we use to warp points. Defaults to rigid 6D warp.
#           * \param[in] warp_fcn a shared pointer to an object that warps points
#           */
#         void
#         setWarpFunction (const boost::shared_ptr<WarpPointRigid<PointSource, PointTarget, MatScalar> > &warp_fcn)
#         { warp_point_ = warp_fcn; }
# 
#       protected:
#         bool use_correspondence_weights_;
#         mutable std::vector<double> correspondence_weights_;
# 
#         /** \brief Temporary pointer to the source dataset. */
#         mutable const PointCloudSource *tmp_src_;
# 
#         /** \brief Temporary pointer to the target dataset. */
#         mutable const PointCloudTarget  *tmp_tgt_;
# 
#         /** \brief Temporary pointer to the source dataset indices. */
#         mutable const std::vector<int> *tmp_idx_src_;
# 
#         /** \brief Temporary pointer to the target dataset indices. */
#         mutable const std::vector<int> *tmp_idx_tgt_;
# 
#         /** \brief The parameterized function used to warp the source to the target. */
#         boost::shared_ptr<pcl::registration::WarpPointRigid<PointSource, PointTarget, MatScalar> > warp_point_;
#         
#         /** Base functor all the models that need non linear optimization must
#           * define their own one and implement operator() (const Eigen::VectorXd& x, Eigen::VectorXd& fvec)
#           * or operator() (const Eigen::VectorXf& x, Eigen::VectorXf& fvec) dependening on the choosen _Scalar
#           */
#         template<typename _Scalar, int NX=Eigen::Dynamic, int NY=Eigen::Dynamic>
#         struct Functor
#         {
#           typedef _Scalar Scalar;
#           enum 
#           {
#             InputsAtCompileTime = NX,
#             ValuesAtCompileTime = NY
#           };
#           typedef Eigen::Matrix<_Scalar,InputsAtCompileTime,1> InputType;
#           typedef Eigen::Matrix<_Scalar,ValuesAtCompileTime,1> ValueType;
#           typedef Eigen::Matrix<_Scalar,ValuesAtCompileTime,InputsAtCompileTime> JacobianType;
# 
#           /** \brief Empty Construtor. */
#           Functor () : m_data_points_ (ValuesAtCompileTime) {}
# 
#           /** \brief Constructor
#             * \param[in] m_data_points number of data points to evaluate.
#             */
#           Functor (int m_data_points) : m_data_points_ (m_data_points) {}
#         
#           /** \brief Destructor. */
#           virtual ~Functor () {}
# 
#           /** \brief Get the number of values. */ 
#           int
#           values () const { return (m_data_points_); }
# 
#           protected:
#             int m_data_points_;
#         };
# 
#         struct OptimizationFunctor : public Functor<MatScalar>
#         {
#           using Functor<MatScalar>::values;
# 
#           /** Functor constructor
#             * \param[in] m_data_points the number of data points to evaluate
#             * \param[in,out] estimator pointer to the estimator object
#             */
#           OptimizationFunctor (int m_data_points, 
#                                const TransformationEstimationPointToPlaneWeighted *estimator)
#             :  Functor<MatScalar> (m_data_points), estimator_ (estimator) 
#           {}
# 
#           /** Copy constructor
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctor (const OptimizationFunctor &src) : 
#             Functor<MatScalar> (src.m_data_points_), estimator_ ()
#           {
#             *this = src;
#           }
# 
#           /** Copy operator
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctor& 
#           operator = (const OptimizationFunctor &src) 
#           { 
#             Functor<MatScalar>::operator=(src);
#             estimator_ = src.estimator_; 
#             return (*this); 
#           }
# 
#           /** \brief Destructor. */
#           virtual ~OptimizationFunctor () {}
# 
#           /** Fill fvec from x. For the current state vector x fill the f values
#             * \param[in] x state vector
#             * \param[out] fvec f values vector
#             */
#           int 
#           operator () (const VectorX &x, VectorX &fvec) const;
# 
#           const TransformationEstimationPointToPlaneWeighted<PointSource, PointTarget, MatScalar> *estimator_;
#         };
# 
#         struct OptimizationFunctorWithIndices : public Functor<MatScalar>
#         {
#           using Functor<MatScalar>::values;
# 
#           /** Functor constructor
#             * \param[in] m_data_points the number of data points to evaluate
#             * \param[in,out] estimator pointer to the estimator object
#             */
#           OptimizationFunctorWithIndices (int m_data_points, 
#                                           const TransformationEstimationPointToPlaneWeighted *estimator)
#             : Functor<MatScalar> (m_data_points), estimator_ (estimator) 
#           {}
# 
#           /** Copy constructor
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctorWithIndices (const OptimizationFunctorWithIndices &src)
#             : Functor<MatScalar> (src.m_data_points_), estimator_ ()
#           {
#             *this = src;
#           }
# 
#           /** Copy operator
#             * \param[in] src the optimization functor to copy into this
#             */
#           inline OptimizationFunctorWithIndices& 
#           operator = (const OptimizationFunctorWithIndices &src) 
#           { 
#             Functor<MatScalar>::operator=(src);
#             estimator_ = src.estimator_; 
#             return (*this); 
#           }
# 
#           /** \brief Destructor. */
#           virtual ~OptimizationFunctorWithIndices () {}
# 
#           /** Fill fvec from x. For the current state vector x fill the f values
#             * \param[in] x state vector
#             * \param[out] fvec f values vector
#             */
#           int 
#           operator () (const VectorX &x, VectorX &fvec) const;
# 
#           const TransformationEstimationPointToPlaneWeighted<PointSource, PointTarget, MatScalar> *estimator_;
#         };
#       public:
#         EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#     };
###

# transformation_estimation_svd.h
# template <typename PointSource, typename PointTarget>
# class TransformationEstimationSVD : public TransformationEstimation<PointSource, PointTarget>
cdef extern from "pcl/registration/transformation_estimation_svd.h" namespace "pcl" nogil:
    cdef cppclass TransformationEstimationSVD[Source, Target](TransformationEstimation[Source, Target]):
        TransformationEstimationSVD ()
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] indices_src the vector of indices describing the points of interest in \a cloud_src
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] indices_tgt the vector of indices describing the correspondences of the interst points from \a indices_src
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # inline void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const std::vector<int> &indices_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const std::vector<int> &indices_tgt,
        #     Eigen::Matrix4f &transformation_matrix);
        # /** \brief Estimate a rigid rotation transformation between a source and a target point cloud using SVD.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[in] correspondences the vector of correspondences between source and target point cloud
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   */
        # void
        # estimateRigidTransformation (
        #     const pcl::PointCloud<PointSource> &cloud_src,
        #     const pcl::PointCloud<PointTarget> &cloud_tgt,
        #     const pcl::Correspondences &correspondences,
        #     Eigen::Matrix4f &transformation_matrix);
        # protected:
        # /** \brief Obtain a 4x4 rigid transformation matrix from a correlation matrix H = src * tgt'
        #   * \param[in] cloud_src_demean the input source cloud, demeaned, in Eigen format
        #   * \param[in] centroid_src the input source centroid, in Eigen format
        #   * \param[in] cloud_tgt_demean the input target cloud, demeaned, in Eigen format
        #   * \param[in] centroid_tgt the input target cloud, in Eigen format
        #   * \param[out] transformation_matrix the resultant 4x4 rigid transformation matrix
        #   */ 
        # void
        # getTransformationFromCorrelation (const Eigen::MatrixXf &cloud_src_demean,
        #                                   const Eigen::Vector4f &centroid_src,
        #                                   const Eigen::MatrixXf &cloud_tgt_demean,
        #                                   const Eigen::Vector4f &centroid_tgt,
        #                                   Eigen::Matrix4f &transformation_matrix);
###

# transformation_estimation_svd_scale.h
# namespace pcl
#   namespace registration
#     template <typename PointSource, typename PointTarget, typename Scalar = float>
#     class TransformationEstimationSVDScale : public TransformationEstimationSVD<PointSource, PointTarget, Scalar>
#     {
#       public:
#         typedef boost::shared_ptr<TransformationEstimationSVDScale<PointSource, PointTarget, Scalar> > Ptr;
#         typedef boost::shared_ptr<const TransformationEstimationSVDScale<PointSource, PointTarget, Scalar> > ConstPtr;
# 
#         typedef typename TransformationEstimationSVD<PointSource, PointTarget, Scalar>::Matrix4 Matrix4;
# 
#         /** \brief Inherits from TransformationEstimationSVD, but forces it to not use the Umeyama method */
#         TransformationEstimationSVDScale ():
#           TransformationEstimationSVD<PointSource, PointTarget, Scalar> (false)
#       {}
# 
#       protected:
#         /** \brief Obtain a 4x4 rigid transformation matrix from a correlation matrix H = src * tgt'
#           * \param[in] cloud_src_demean the input source cloud, demeaned, in Eigen format
#           * \param[in] centroid_src the input source centroid, in Eigen format
#           * \param[in] cloud_tgt_demean the input target cloud, demeaned, in Eigen format
#           * \param[in] centroid_tgt the input target cloud, in Eigen format
#           * \param[out] transformation_matrix the resultant 4x4 rigid transformation matrix
#           */ 
#         void
#         getTransformationFromCorrelation (const Eigen::Matrix<Scalar, Eigen::Dynamic, Eigen::Dynamic> &cloud_src_demean,
#                                           const Eigen::Matrix<Scalar, 4, 1> &centroid_src,
#                                           const Eigen::Matrix<Scalar, Eigen::Dynamic, Eigen::Dynamic> &cloud_tgt_demean,
#                                           const Eigen::Matrix<Scalar, 4, 1> &centroid_tgt,
#                                           Matrix4 &transformation_matrix) const;
###

# transformation_validation.h
# template <typename PointSource, typename PointTarget>
# class TransformationValidation
cdef extern from "pcl/registration/transformation_validation.h" namespace "pcl" nogil:
    cdef cppclass TransformationValidation[Source, Target]:
        TransformationValidation ()
        # public:
        # ctypedef pcl::PointCloud<PointSource> PointCloudSource;
        # ctypedef typename PointCloudSource::Ptr PointCloudSourcePtr;
        # ctypedef typename PointCloudSource::ConstPtr PointCloudSourceConstPtr;
        # ctypedef pcl::PointCloud<PointTarget> PointCloudTarget;
        # ctypedef typename PointCloudTarget::Ptr PointCloudTargetPtr;
        # ctypedef typename PointCloudTarget::ConstPtr PointCloudTargetConstPtr;
        # /** \brief Validate the given transformation with respect to the input cloud data, and return a score.
        #   * \param[in] cloud_src the source point cloud dataset
        #   * \param[in] cloud_tgt the target point cloud dataset
        #   * \param[out] transformation_matrix the resultant transformation matrix
        #   * \return the score or confidence measure for the given
        #   * transformation_matrix with respect to the input data
        # */
        # virtual double validateTransformation (
        #    const cpp.PointCloudPtr_t &cloud_src,
        #    const cpp.PointCloudPtr_t &cloud_tgt,
        #    const Matrix4f &transformation_matrix) = 0;
        # ctypedef shared_ptr[TransformationValidation[PointSource, PointTarget] ] Ptr;
        # ctypedef shared_ptr[const TransformationValidation[PointSource, PointTarget] ] ConstPtr;
###

# transformation_validation_euclidean.h
# template <typename PointSource, typename PointTarget>
# class TransformationValidationEuclidean
cdef extern from "pcl/registration/transformation_validation_euclidean.h" namespace "pcl" nogil:
    cdef cppclass TransformationValidationEuclidean[Source, Target]:
        TransformationValidationEuclidean ()
        # public:
        # ctypedef boost::shared_ptr<TransformationValidation<PointSource, PointTarget> > Ptr;
        # ctypedef boost::shared_ptr<const TransformationValidation<PointSource, PointTarget> > ConstPtr;
        # ctypedef typename pcl::KdTree<PointTarget> KdTree;
        # ctypedef typename pcl::KdTree<PointTarget>::Ptr KdTreePtr;
        # ctypedef typename KdTree::PointRepresentationConstPtr PointRepresentationConstPtr;
        # ctypedef typename TransformationValidation<PointSource, PointTarget>::PointCloudSourceConstPtr PointCloudSourceConstPtr;
        # ctypedef typename TransformationValidation<PointSource, PointTarget>::PointCloudTargetConstPtr PointCloudTargetConstPtr;
        inline void setMaxRange (double max_range)
        double validateTransformation (
            const cpp.PointCloudPtr_t &cloud_src,
            const cpp.PointCloudPtr_t &cloud_tgt,
            const Matrix4f &transformation_matrix)
###

# transforms.h
# common/transforms.h
###

# warp_point_rigid_3d.h
# template <class PointSourceT, class PointTargetT>
# class WarpPointRigid3D : public WarpPointRigid<PointSourceT, PointTargetT>
cdef extern from "pcl/registration/warp_point_rigid_3d.h" namespace "pcl" nogil:
    cdef cppclass WarpPointRigid3D[Source, Target](WarpPointRigid[Source, Target]):
        WarpPointRigid3D ()
        # public:
        # virtual void setParam (const Eigen::VectorXf & p)
###

# warp_point_rigid_6d.h
# template <class PointSourceT, class PointTargetT>
# class WarpPointRigid6D : public WarpPointRigid<PointSourceT, PointTargetT>
cdef extern from "pcl/registration/warp_point_rigid_6d.h" namespace "pcl" nogil:
    cdef cppclass WarpPointRigid6D[Source, Target](WarpPointRigid[Source, Target]):
        WarpPointRigid6D ()
        # public:
        # virtual void setParam (const Eigen::VectorXf & p)

###

