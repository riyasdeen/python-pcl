from libc.stddef cimport size_t

from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

# NG
# from libcpp.memory cimport shared_ptr
from boost_shared_ptr cimport shared_ptr

# main
# cimport pcl_defs as cpp
# 
from pcl_defs cimport PointIndices
from pcl_defs cimport ModelCoefficients
from pcl_defs cimport PointCloud
from pcl_defs cimport PointXYZ
from pcl_defs cimport PointXYZI
from pcl_defs cimport PointXYZRGB
from pcl_defs cimport PointXYZRGBA
from pcl_defs cimport Normal

from pcl_sample_consensus cimport SacModel

from vector cimport vector as vector2

###############################################################################
# Types
###############################################################################

### base class ###

cdef extern from "pcl/segmentation/sac_segmentation.h" namespace "pcl":
    cdef cppclass SACSegmentationFromNormals[T, N]:
        SACSegmentationFromNormals()
        void setOptimizeCoefficients (bool)
        void setModelType (SacModel)
        void setMethodType (int)
        void setNormalDistanceWeight (float)
        void setMaxIterations (int)
        void setDistanceThreshold (float)
        void setRadiusLimits (float, float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void setInputNormals (shared_ptr[PointCloud[N]])
        void setEpsAngle (double ea)
        void segment (PointIndices, ModelCoefficients)
        void setMinMaxOpeningAngle(double, double)
        void getMinMaxOpeningAngle(double, double)

    cdef cppclass SACSegmentation[T]:
        void setOptimizeCoefficients (bool)
        void setModelType (SacModel)
        void setMethodType (int)
        void setDistanceThreshold (float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void segment (PointIndices, ModelCoefficients)

ctypedef SACSegmentation[PointXYZ] SACSegmentation_t
ctypedef SACSegmentation[PointXYZI] SACSegmentation_PointXYZI_t
ctypedef SACSegmentation[PointXYZRGB] SACSegmentation_PointXYZRGB_t
ctypedef SACSegmentation[PointXYZRGBA] SACSegmentation_PointXYZRGBA_t
ctypedef SACSegmentationFromNormals[PointXYZ,Normal] SACSegmentationNormal_t
ctypedef SACSegmentationFromNormals[PointXYZI,Normal] SACSegmentation_PointXYZI_Normal_t
ctypedef SACSegmentationFromNormals[PointXYZRGB,Normal] SACSegmentation_PointXYZRGB_Normal_t
ctypedef SACSegmentationFromNormals[PointXYZRGBA,Normal] SACSegmentation_PointXYZRGBA_Normal_t

###
# comparator.h
# namespace pcl
#   /** \brief Comparator is the base class for comparators that compare two points given some function.
#     * Currently intended for use with OrganizedConnectedComponentSegmentation
#     * \author Alex Trevor
# template <typename PointT>
# class Comparator
cdef extern from "pcl/segmentation/comparator.h" namespace "pcl":
    cdef cppclass Comparator[T]:
        Comparator()
#       public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
#       typedef boost::shared_ptr<Comparator<PointT> > Ptr;
#       typedef boost::shared_ptr<const Comparator<PointT> > ConstPtr;
#       
#       /** \brief Set the input cloud for the comparator.
#         * \param[in] cloud the point cloud this comparator will operate on
#         */
#       virtual void setInputCloud (const PointCloudConstPtr& cloud)
#
#       /** \brief Get the input cloud this comparator operates on. */
#       virtual PointCloudConstPtr getInputCloud () const
# 
#       /** \brief Compares the two points in the input cloud designated by these two indices.
#         * This is pure virtual and must be implemented by subclasses with some comparison function.
#         * \param[in] idx1 the index of the first point.
#         * \param[in] idx2 the index of the second point.
#         */
#       virtual bool compare (int idx1, int idx2) const = 0;
#       
#     protected:
#       PointCloudConstPtr input_;
###

# plane_coefficient_comparator.h
# namespace pcl
# /** \brief PlaneCoefficientComparator is a Comparator that operates on plane coefficients, for use in planar segmentation.
#   * In conjunction with OrganizedConnectedComponentSegmentation, this allows planes to be segmented from organized data.
#   *
#   * \author Alex Trevor
#   */
# template<typename PointT, typename PointNT>
# class PlaneCoefficientComparator: public Comparator<PointT>
cdef extern from "pcl/segmentation/plane_coefficient_comparator.h" namespace "pcl":
    cdef cppclass PlaneCoefficientComparator[T, NT](Comparator[T]):
        PlaneCoefficientComparator()
        # PlaneCoefficientComparator (boost::shared_ptr<std::vector<float> >& plane_coeff_d)
#       public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#       typedef boost::shared_ptr<PlaneCoefficientComparator<PointT, PointNT> > Ptr;
#       typedef boost::shared_ptr<const PlaneCoefficientComparator<PointT, PointNT> > ConstPtr;
#       using pcl::Comparator<PointT>::input_;
# 
#       virtual void setInputCloud (const PointCloudConstPtr& cloud)
#       /** \brief Provide a pointer to the input normals.
#         * \param[in] normals the input normal cloud
#       inline void setInputNormals (const PointCloudNConstPtr &normals)
#       /** \brief Get the input normals. */
#       inline PointCloudNConstPtr getInputNormals () const
#       /** \brief Provide a pointer to a vector of the d-coefficient of the planes' hessian normal form.  a, b, and c are provided by the normal cloud.
#         * \param[in] plane_coeff_d a pointer to the plane coefficients.
#       void setPlaneCoeffD (boost::shared_ptr<std::vector<float> >& plane_coeff_d)
# 
#       /** \brief Provide a pointer to a vector of the d-coefficient of the planes' hessian normal form.  a, b, and c are provided by the normal cloud.
#         * \param[in] plane_coeff_d a pointer to the plane coefficients.
#       void setPlaneCoeffD (std::vector<float>& plane_coeff_d)
#       /** \brief Get a pointer to the vector of the d-coefficient of the planes' hessian normal form. */
#       const std::vector<float>& getPlaneCoeffD () const
#       /** \brief Set the tolerance in radians for difference in normal direction between neighboring points, to be considered part of the same plane.
#         * \param[in] angular_threshold the tolerance in radians
#       virtual void setAngularThreshold (float angular_threshold)
#       /** \brief Get the angular threshold in radians for difference in normal direction between neighboring points, to be considered part of the same plane. */
#       inline float getAngularThreshold () const
#       /** \brief Set the tolerance in meters for difference in perpendicular distance (d component of plane equation) to the plane between neighboring points, to be considered part of the same plane.
#         * \param[in] distance_threshold the tolerance in meters (at 1m)
#         * \param[in] depth_dependent whether to scale the threshold based on range from the sensor (default: false)
#       void setDistanceThreshold (float distance_threshold, bool depth_dependent = false)
#       /** \brief Get the distance threshold in meters (d component of plane equation) between neighboring points, to be considered part of the same plane. */
#       inline float getDistanceThreshold () const
#       /** \brief Compare points at two indices by their plane equations.  True if the angle between the normals is less than the angular threshold,
#         * and the difference between the d component of the normals is less than distance threshold, else false
#         * \param idx1 The first index for the comparison
#         * \param idx2 The second index for the comparison
#       virtual bool compare (int idx1, int idx2) const
#       
#       protected:
#       PointCloudNConstPtr normals_;
#       boost::shared_ptr<std::vector<float> > plane_coeff_d_;
#       float angular_threshold_;
#       float distance_threshold_;
#       bool depth_dependent_;
#       Eigen::Vector3f z_axis_;
#       public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
###

### Inheritance class ###

# edge_aware_plane_comparator.h
# namespace pcl
# /** \brief EdgeAwarePlaneComparator is a Comparator that operates on plane coefficients, 
#   * for use in planar segmentation.
#   * In conjunction with OrganizedConnectedComponentSegmentation, this allows planes to be segmented from organized data.
#   * \author Stefan Holzer, Alex Trevor
#   */
# template<typename PointT, typename PointNT>
# class EdgeAwarePlaneComparator: public PlaneCoefficientComparator<PointT, PointNT>
cdef extern from "pcl/segmentation/edge_aware_plane_comparator.h" namespace "pcl":
    cdef cppclass EdgeAwarePlaneComparator[T, NT](PlaneCoefficientComparator[T, NT]):
        EdgeAwarePlaneComparator()
        # EdgeAwarePlaneComparator (const float *distance_map)
        # public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#       typedef boost::shared_ptr<EdgeAwarePlaneComparator<PointT, PointNT> > Ptr;
#       typedef boost::shared_ptr<const EdgeAwarePlaneComparator<PointT, PointNT> > ConstPtr;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::input_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::normals_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::plane_coeff_d_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::angular_threshold_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::distance_threshold_;
# 
#       /** \brief Set a distance map to use. For an example of a valid distance map see 
#         * \ref OrganizedIntegralImageNormalEstimation
#         * \param[in] distance_map the distance map to use
#         */
#       inline void setDistanceMap (const float *distance_map)
#       /** \brief Return the distance map used. */
#       const float* getDistanceMap () const
#       
#       protected:
#       /** \brief Compare two neighboring points, by using normal information, curvature, and euclidean distance information.
#         * \param[in] idx1 The index of the first point.
#         * \param[in] idx2 The index of the second point.
#       bool compare (int idx1, int idx2) const
#     	protected:
#       const float* distance_map_;
###

# euclidean_cluster_comparator.h
# namespace pcl
# /** \brief EuclideanClusterComparator is a comparator used for finding clusters supported by planar surfaces.
#   * This needs to be run as a second pass after extracting planar surfaces, using MultiPlaneSegmentation for example.
#   * \author Alex Trevor
# template<typename PointT, typename PointNT, typename PointLT>
# class EuclideanClusterComparator: public Comparator<PointT>
cdef extern from "pcl/segmentation/euclidean_cluster_comparator.h" namespace "pcl":
    cdef cppclass EuclideanClusterComparator[T, NT, LT](Comparator[T]):
        EuclideanClusterComparator()
#       public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#       typedef typename pcl::PointCloud<PointLT> PointCloudL;
#       typedef typename PointCloudL::Ptr PointCloudLPtr;
#       typedef typename PointCloudL::ConstPtr PointCloudLConstPtr;
#       typedef boost::shared_ptr<EuclideanClusterComparator<PointT, PointNT, PointLT> > Ptr;
#       typedef boost::shared_ptr<const EuclideanClusterComparator<PointT, PointNT, PointLT> > ConstPtr;
#       using pcl::Comparator<PointT>::input_;
#       
#       virtual void setInputCloud (const PointCloudConstPtr& cloud)
#       /** \brief Provide a pointer to the input normals.
#         * \param[in] normals the input normal cloud
#       inline void setInputNormals (const PointCloudNConstPtr &normals)
#       /** \brief Get the input normals. */
#       inline PointCloudNConstPtr getInputNormals () const
#       /** \brief Set the tolerance in radians for difference in normal direction between neighboring points, to be considered part of the same plane.
#         * \param[in] angular_threshold the tolerance in radians
#       virtual inline void setAngularThreshold (float angular_threshold)
#       /** \brief Get the angular threshold in radians for difference in normal direction between neighboring points, to be considered part of the same plane. */
#       inline float getAngularThreshold () const
#       /** \brief Set the tolerance in meters for difference in perpendicular distance (d component of plane equation) to the plane between neighboring points, to be considered part of the same plane.
#         * \param[in] distance_threshold the tolerance in meters
#       inline void setDistanceThreshold (float distance_threshold, bool depth_dependent)
#       /** \brief Get the distance threshold in meters (d component of plane equation) between neighboring points, to be considered part of the same plane. */
#       inline float getDistanceThreshold () const
#       /** \brief Set label cloud
#         * \param[in] labels The label cloud
#       void setLabels (PointCloudLPtr& labels)
#       /** \brief Set labels in the label cloud to exclude.
#         * \param exclude_labels a vector of bools corresponding to whether or not a given label should be considered
#       void setExcludeLabels (std::vector<bool>& exclude_labels)
#       /** \brief Compare points at two indices by their plane equations.  True if the angle between the normals is less than the angular threshold,
#         * and the difference between the d component of the normals is less than distance threshold, else false
#         * \param idx1 The first index for the comparison
#         * \param idx2 The second index for the comparison
#       virtual bool compare (int idx1, int idx2) const
#       
#       protected:
#       PointCloudNConstPtr normals_;
#       PointCloudLPtr labels_;
#       boost::shared_ptr<std::vector<bool> > exclude_labels_;
#       float angular_threshold_;
#       float distance_threshold_;
#       bool depth_dependent_;
#       Eigen::Vector3f z_axis_;
###

# euclidean_plane_coefficient_comparator.h
# namespace pcl
# /** \brief EuclideanPlaneCoefficientComparator is a Comparator that operates on plane coefficients, 
#   * for use in planar segmentation.
#   * In conjunction with OrganizedConnectedComponentSegmentation, this allows planes to be segmented from organized data.
#   * \author Alex Trevor
# template<typename PointT, typename PointNT>
# class EuclideanPlaneCoefficientComparator: public PlaneCoefficientComparator<PointT, PointNT>
cdef extern from "pcl/segmentation/euclidean_plane_coefficient_comparator.h" namespace "pcl":
    cdef cppclass EuclideanPlaneCoefficientComparator[T, NT](PlaneCoefficientComparator[T, NT]):
        EuclideanPlaneCoefficientComparator()
#     	public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#       typedef boost::shared_ptr<EuclideanPlaneCoefficientComparator<PointT, PointNT> > Ptr;
#       typedef boost::shared_ptr<const EuclideanPlaneCoefficientComparator<PointT, PointNT> > ConstPtr;
#       using pcl::Comparator<PointT>::input_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::normals_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::angular_threshold_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::distance_threshold_;
# 
#       /** \brief Compare two neighboring points, by using normal information, and euclidean distance information.
#         * \param[in] idx1 The index of the first point.
#         * \param[in] idx2 The index of the second point.
#         */
#       virtual bool compare (int idx1, int idx2) const
###

# extract_clusters.h
# namespace pcl
# /** \brief Decompose a region of space into clusters based on the Euclidean distance between points
#   * \param cloud the point cloud message
#   * \param tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching
#   * \note the tree has to be created as a spatial locator on \a cloud
#   * \param tolerance the spatial cluster tolerance as a measure in L2 Euclidean space
#   * \param clusters the resultant clusters containing point indices (as a vector of PointIndices)
#   * \param min_pts_per_cluster minimum number of points that a cluster may contain (default: 1)
#   * \param max_pts_per_cluster maximum number of points that a cluster may contain (default: max int)
#   * \ingroup segmentation
# template <typename PointT> void 
# extractEuclideanClusters (
#       const PointCloud<PointT> &cloud, const boost::shared_ptr<search::Search<PointT> > &tree, 
#       float tolerance, std::vector<PointIndices> &clusters, 
#       unsigned int min_pts_per_cluster = 1, unsigned int max_pts_per_cluster = (std::numeric_limits<int>::max) ());
# 
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief Decompose a region of space into clusters based on the Euclidean distance between points
#     * \param cloud the point cloud message
#     * \param indices a list of point indices to use from \a cloud
#     * \param tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching
#     * \note the tree has to be created as a spatial locator on \a cloud and \a indices
#     * \param tolerance the spatial cluster tolerance as a measure in L2 Euclidean space
#     * \param clusters the resultant clusters containing point indices (as a vector of PointIndices)
#     * \param min_pts_per_cluster minimum number of points that a cluster may contain (default: 1)
#     * \param max_pts_per_cluster maximum number of points that a cluster may contain (default: max int)
#     * \ingroup segmentation
#     */
#   template <typename PointT> void 
#   extractEuclideanClusters (
#       const PointCloud<PointT> &cloud, const std::vector<int> &indices, 
#       const boost::shared_ptr<search::Search<PointT> > &tree, float tolerance, std::vector<PointIndices> &clusters, 
#       unsigned int min_pts_per_cluster = 1, unsigned int max_pts_per_cluster = (std::numeric_limits<int>::max) ());
# 
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief Decompose a region of space into clusters based on the euclidean distance between points, and the normal
#     * angular deviation
#     * \param cloud the point cloud message
#     * \param normals the point cloud message containing normal information
#     * \param tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching
#     * \note the tree has to be created as a spatial locator on \a cloud
#     * \param tolerance the spatial cluster tolerance as a measure in the L2 Euclidean space
#     * \param clusters the resultant clusters containing point indices (as a vector of PointIndices)
#     * \param eps_angle the maximum allowed difference between normals in radians for cluster/region growing
#     * \param min_pts_per_cluster minimum number of points that a cluster may contain (default: 1)
#     * \param max_pts_per_cluster maximum number of points that a cluster may contain (default: max int)
#     * \ingroup segmentation
#     */
#   template <typename PointT, typename Normal> void 
#   extractEuclideanClusters (
#       const PointCloud<PointT> &cloud, const PointCloud<Normal> &normals, 
#       float tolerance, const boost::shared_ptr<KdTree<PointT> > &tree, 
#       std::vector<PointIndices> &clusters, double eps_angle, 
#       unsigned int min_pts_per_cluster = 1, 
#       unsigned int max_pts_per_cluster = (std::numeric_limits<int>::max) ())
#   {
#     if (tree->getInputCloud ()->points.size () != cloud.points.size ())
#     {
#       PCL_ERROR ("[pcl::extractEuclideanClusters] Tree built for a different point cloud dataset (%zu) than the input cloud (%zu)!\n", tree->getInputCloud ()->points.size (), cloud.points.size ());
#       return;
#     }
#     if (cloud.points.size () != normals.points.size ())
#     {
#       PCL_ERROR ("[pcl::extractEuclideanClusters] Number of points in the input point cloud (%zu) different than normals (%zu)!\n", cloud.points.size (), normals.points.size ());
#       return;
#     }
# 
#     // Create a bool vector of processed point indices, and initialize it to false
#     std::vector<bool> processed (cloud.points.size (), false);
# 
#     std::vector<int> nn_indices;
#     std::vector<float> nn_distances;
#     // Process all points in the indices vector
#     for (size_t i = 0; i < cloud.points.size (); ++i)
#     {
#       if (processed[i])
#         continue;
# 
#       std::vector<unsigned int> seed_queue;
#       int sq_idx = 0;
#       seed_queue.push_back (i);
# 
#       processed[i] = true;
# 
#       while (sq_idx < static_cast<int> (seed_queue.size ()))
#       {
#         // Search for sq_idx
#         if (!tree->radiusSearch (seed_queue[sq_idx], tolerance, nn_indices, nn_distances))
#         {
#           sq_idx++;
#           continue;
#         }
# 
#         for (size_t j = 1; j < nn_indices.size (); ++j)             // nn_indices[0] should be sq_idx
#         {
#           if (processed[nn_indices[j]])                         // Has this point been processed before ?
#             continue;
# 
#           //processed[nn_indices[j]] = true;
#           // [-1;1]
#           double dot_p = normals.points[i].normal[0] * normals.points[nn_indices[j]].normal[0] +
#                          normals.points[i].normal[1] * normals.points[nn_indices[j]].normal[1] +
#                          normals.points[i].normal[2] * normals.points[nn_indices[j]].normal[2];
#           if ( fabs (acos (dot_p)) < eps_angle )
#           {
#             processed[nn_indices[j]] = true;
#             seed_queue.push_back (nn_indices[j]);
#           }
#         }
# 
#         sq_idx++;
#       }
# 
#       // If this queue is satisfactory, add to the clusters
#       if (seed_queue.size () >= min_pts_per_cluster && seed_queue.size () <= max_pts_per_cluster)
#       {
#         pcl::PointIndices r;
#         r.indices.resize (seed_queue.size ());
#         for (size_t j = 0; j < seed_queue.size (); ++j)
#           r.indices[j] = seed_queue[j];
# 
#         // These two lines should not be needed: (can anyone confirm?) -FF
#         std::sort (r.indices.begin (), r.indices.end ());
#         r.indices.erase (std::unique (r.indices.begin (), r.indices.end ()), r.indices.end ());
# 
#         r.header = cloud.header;
#         clusters.push_back (r);   // We could avoid a copy by working directly in the vector
#       }
#     }
#   }
# 
# 
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief Decompose a region of space into clusters based on the euclidean distance between points, and the normal
#     * angular deviation
#     * \param cloud the point cloud message
#     * \param normals the point cloud message containing normal information
#     * \param indices a list of point indices to use from \a cloud
#     * \param tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching
#     * \note the tree has to be created as a spatial locator on \a cloud
#     * \param tolerance the spatial cluster tolerance as a measure in the L2 Euclidean space
#     * \param clusters the resultant clusters containing point indices (as PointIndices)
#     * \param eps_angle the maximum allowed difference between normals in degrees for cluster/region growing
#     * \param min_pts_per_cluster minimum number of points that a cluster may contain (default: 1)
#     * \param max_pts_per_cluster maximum number of points that a cluster may contain (default: max int)
#     * \ingroup segmentation
#     */
#   template <typename PointT, typename Normal> 
#   void extractEuclideanClusters (
#       const PointCloud<PointT> &cloud, const PointCloud<Normal> &normals, 
#       const std::vector<int> &indices, const boost::shared_ptr<KdTree<PointT> > &tree, 
#       float tolerance, std::vector<PointIndices> &clusters, double eps_angle, 
#       unsigned int min_pts_per_cluster = 1, 
#       unsigned int max_pts_per_cluster = (std::numeric_limits<int>::max) ())
#   {
#     // \note If the tree was created over <cloud, indices>, we guarantee a 1-1 mapping between what the tree returns
#     //and indices[i]
#     if (tree->getInputCloud ()->points.size () != cloud.points.size ())
#     {
#       PCL_ERROR ("[pcl::extractEuclideanClusters] Tree built for a different point cloud dataset (%zu) than the input cloud (%zu)!\n", tree->getInputCloud ()->points.size (), cloud.points.size ());
#       return;
#     }
#     if (tree->getIndices ()->size () != indices.size ())
#     {
#       PCL_ERROR ("[pcl::extractEuclideanClusters] Tree built for a different set of indices (%zu) than the input set (%zu)!\n", tree->getIndices ()->size (), indices.size ());
#       return;
#     }
#     if (cloud.points.size () != normals.points.size ())
#     {
#       PCL_ERROR ("[pcl::extractEuclideanClusters] Number of points in the input point cloud (%zu) different than normals (%zu)!\n", cloud.points.size (), normals.points.size ());
#       return;
#     }
#     // Create a bool vector of processed point indices, and initialize it to false
#     std::vector<bool> processed (cloud.points.size (), false);
# 
#     std::vector<int> nn_indices;
#     std::vector<float> nn_distances;
#     // Process all points in the indices vector
#     for (size_t i = 0; i < indices.size (); ++i)
#     {
#       if (processed[indices[i]])
#         continue;
# 
#       std::vector<int> seed_queue;
#       int sq_idx = 0;
#       seed_queue.push_back (indices[i]);
# 
#       processed[indices[i]] = true;
# 
#       while (sq_idx < static_cast<int> (seed_queue.size ()))
#       {
#         // Search for sq_idx
#         if (!tree->radiusSearch (cloud.points[seed_queue[sq_idx]], tolerance, nn_indices, nn_distances))
#         {
#           sq_idx++;
#           continue;
#         }
# 
#         for (size_t j = 1; j < nn_indices.size (); ++j)             // nn_indices[0] should be sq_idx
#         {
#           if (processed[nn_indices[j]])                             // Has this point been processed before ?
#             continue;
# 
#           //processed[nn_indices[j]] = true;
#           // [-1;1]
#           double dot_p =
#             normals.points[indices[i]].normal[0] * normals.points[indices[nn_indices[j]]].normal[0] +
#             normals.points[indices[i]].normal[1] * normals.points[indices[nn_indices[j]]].normal[1] +
#             normals.points[indices[i]].normal[2] * normals.points[indices[nn_indices[j]]].normal[2];
#           if ( fabs (acos (dot_p)) < eps_angle )
#           {
#             processed[nn_indices[j]] = true;
#             seed_queue.push_back (nn_indices[j]);
#           }
#         }
# 
#         sq_idx++;
#       }
# 
#       // If this queue is satisfactory, add to the clusters
#       if (seed_queue.size () >= min_pts_per_cluster && seed_queue.size () <= max_pts_per_cluster)
#       {
#         pcl::PointIndices r;
#         r.indices.resize (seed_queue.size ());
#         for (size_t j = 0; j < seed_queue.size (); ++j)
#           r.indices[j] = seed_queue[j];
# 
#         // These two lines should not be needed: (can anyone confirm?) -FF
#         std::sort (r.indices.begin (), r.indices.end ());
#         r.indices.erase (std::unique (r.indices.begin (), r.indices.end ()), r.indices.end ());
# 
#         r.header = cloud.header;
#         clusters.push_back (r);
#       }
#     }
#   }
# 
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief @b EuclideanClusterExtraction represents a segmentation class for cluster extraction in an Euclidean sense.
#     * \author Radu Bogdan Rusu
#     * \ingroup segmentation
#     */
#   template <typename PointT>
#   class EuclideanClusterExtraction: public PCLBase<PointT>
#   {
#     typedef PCLBase<PointT> BasePCLBase;
# 
#     public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef typename pcl::search::Search<PointT> KdTree;
#       typedef typename pcl::search::Search<PointT>::Ptr KdTreePtr;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#       /** \brief Empty constructor. */
#       EuclideanClusterExtraction () : tree_ (), 
#                                       cluster_tolerance_ (0),
#                                       min_pts_per_cluster_ (1), 
#                                       max_pts_per_cluster_ (std::numeric_limits<int>::max ())
#       {};
# 
#       /** \brief Provide a pointer to the search object.
#         * \param[in] tree a pointer to the spatial search object.
#         */
#       inline void 
#       setSearchMethod (const KdTreePtr &tree) 
#       { 
#         tree_ = tree; 
#       }
# 
#       /** \brief Get a pointer to the search method used. 
#        *  @todo fix this for a generic search tree
#        */
#       inline KdTreePtr 
#       getSearchMethod () const 
#       { 
#         return (tree_); 
#       }
# 
#       /** \brief Set the spatial cluster tolerance as a measure in the L2 Euclidean space
#         * \param[in] tolerance the spatial cluster tolerance as a measure in the L2 Euclidean space
#         */
#       inline void 
#       setClusterTolerance (double tolerance) 
#       { 
#         cluster_tolerance_ = tolerance; 
#       }
# 
#       /** \brief Get the spatial cluster tolerance as a measure in the L2 Euclidean space. */
#       inline double 
#       getClusterTolerance () const 
#       { 
#         return (cluster_tolerance_); 
#       }
# 
#       /** \brief Set the minimum number of points that a cluster needs to contain in order to be considered valid.
#         * \param[in] min_cluster_size the minimum cluster size
#         */
#       inline void 
#       setMinClusterSize (int min_cluster_size) 
#       { 
#         min_pts_per_cluster_ = min_cluster_size; 
#       }
# 
#       /** \brief Get the minimum number of points that a cluster needs to contain in order to be considered valid. */
#       inline int 
#       getMinClusterSize () const 
#       { 
#         return (min_pts_per_cluster_); 
#       }
# 
#       /** \brief Set the maximum number of points that a cluster needs to contain in order to be considered valid.
#         * \param[in] max_cluster_size the maximum cluster size
#         */
#       inline void 
#       setMaxClusterSize (int max_cluster_size) 
#       { 
#         max_pts_per_cluster_ = max_cluster_size; 
#       }
# 
#       /** \brief Get the maximum number of points that a cluster needs to contain in order to be considered valid. */
#       inline int 
#       getMaxClusterSize () const 
#       { 
#         return (max_pts_per_cluster_); 
#       }
# 
#       /** \brief Cluster extraction in a PointCloud given by <setInputCloud (), setIndices ()>
#         * \param[out] clusters the resultant point clusters
#         */
#       void 
#       extract (std::vector<PointIndices> &clusters);
# 
#     protected:
#       // Members derived from the base class
#       using BasePCLBase::input_;
#       using BasePCLBase::indices_;
#       using BasePCLBase::initCompute;
#       using BasePCLBase::deinitCompute;
# 
#       /** \brief A pointer to the spatial search object. */
#       KdTreePtr tree_;
# 
#       /** \brief The spatial cluster tolerance as a measure in the L2 Euclidean space. */
#       double cluster_tolerance_;
# 
#       /** \brief The minimum number of points that a cluster needs to contain in order to be considered valid (default = 1). */
#       int min_pts_per_cluster_;
# 
#       /** \brief The maximum number of points that a cluster needs to contain in order to be considered valid (default = MAXINT). */
#       int max_pts_per_cluster_;
# 
#       /** \brief Class getName method. */
#       virtual std::string getClassName () const { return ("EuclideanClusterExtraction"); }
# 
#   };
# 
#   /** \brief Sort clusters method (for std::sort). 
#     * \ingroup segmentation
#     */
#   inline bool 
#   comparePointClusters (const pcl::PointIndices &a, const pcl::PointIndices &b)
#   {
#     return (a.indices.size () < b.indices.size ());
#   }
# 
###

# extract_labeled_clusters.h
# namespace pcl
# {
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief Decompose a region of space into clusters based on the Euclidean distance between points
#     * \param[in] cloud the point cloud message
#     * \param[in] tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching
#     * \note the tree has to be created as a spatial locator on \a cloud
#     * \param[in] tolerance the spatial cluster tolerance as a measure in L2 Euclidean space
#     * \param[out] labeled_clusters the resultant clusters containing point indices (as a vector of PointIndices)
#     * \param[in] min_pts_per_cluster minimum number of points that a cluster may contain (default: 1)
#     * \param[in] max_pts_per_cluster maximum number of points that a cluster may contain (default: max int)
#     * \param[in] max_label
#     * \ingroup segmentation
#     */
#   template <typename PointT> void 
#   extractLabeledEuclideanClusters (
#       const PointCloud<PointT> &cloud, const boost::shared_ptr<search::Search<PointT> > &tree, 
#       float tolerance, std::vector<std::vector<PointIndices> > &labeled_clusters, 
#       unsigned int min_pts_per_cluster = 1, unsigned int max_pts_per_cluster = (std::numeric_limits<int>::max) (), 
#       unsigned int max_label = (std::numeric_limits<int>::max));
# 
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief @b LabeledEuclideanClusterExtraction represents a segmentation class for cluster extraction in an Euclidean sense, with label info.
#     * \author Koen Buys
#     * \ingroup segmentation
#     */
#   template <typename PointT>
#   class LabeledEuclideanClusterExtraction: public PCLBase<PointT>
#   {
#     typedef PCLBase<PointT> BasePCLBase;
# 
#     public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef typename pcl::search::Search<PointT> KdTree;
#       typedef typename pcl::search::Search<PointT>::Ptr KdTreePtr;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#       /** \brief Empty constructor. */
#       LabeledEuclideanClusterExtraction () : 
#         tree_ (), 
#         cluster_tolerance_ (0),
#         min_pts_per_cluster_ (1), 
#         max_pts_per_cluster_ (std::numeric_limits<int>::max ()),
#         max_label_ (std::numeric_limits<int>::max ())
#       {};
# 
#       /** \brief Provide a pointer to the search object.
#         * \param[in] tree a pointer to the spatial search object.
#         */
#       inline void 
#       setSearchMethod (const KdTreePtr &tree) { tree_ = tree; }
# 
#       /** \brief Get a pointer to the search method used. */
#       inline KdTreePtr 
#       getSearchMethod () const { return (tree_); }
# 
#       /** \brief Set the spatial cluster tolerance as a measure in the L2 Euclidean space
#         * \param[in] tolerance the spatial cluster tolerance as a measure in the L2 Euclidean space
#         */
#       inline void 
#       setClusterTolerance (double tolerance) { cluster_tolerance_ = tolerance; }
# 
#       /** \brief Get the spatial cluster tolerance as a measure in the L2 Euclidean space. */
#       inline double 
#       getClusterTolerance () const { return (cluster_tolerance_); }
# 
#       /** \brief Set the minimum number of points that a cluster needs to contain in order to be considered valid.
#         * \param[in] min_cluster_size the minimum cluster size
#         */
#       inline void 
#       setMinClusterSize (int min_cluster_size) { min_pts_per_cluster_ = min_cluster_size; }
# 
#       /** \brief Get the minimum number of points that a cluster needs to contain in order to be considered valid. */
#       inline int 
#       getMinClusterSize () const { return (min_pts_per_cluster_); }
# 
#       /** \brief Set the maximum number of points that a cluster needs to contain in order to be considered valid.
#         * \param[in] max_cluster_size the maximum cluster size
#         */
#       inline void 
#       setMaxClusterSize (int max_cluster_size) { max_pts_per_cluster_ = max_cluster_size; }
# 
#       /** \brief Get the maximum number of points that a cluster needs to contain in order to be considered valid. */
#       inline int 
#       getMaxClusterSize () const { return (max_pts_per_cluster_); }
# 
#       /** \brief Set the maximum number of labels in the cloud.
#         * \param[in] max_label the maximum
#         */
#       inline void 
#       setMaxLabels (unsigned int max_label) { max_label_ = max_label; }
# 
#       /** \brief Get the maximum number of labels */
#       inline unsigned int 
#       getMaxLabels () const { return (max_label_); }
# 
#       /** \brief Cluster extraction in a PointCloud given by <setInputCloud (), setIndices ()>
#         * \param[out] labeled_clusters the resultant point clusters
#         */
#       void 
#       extract (std::vector<std::vector<PointIndices> > &labeled_clusters);
# 
#     protected:
#       // Members derived from the base class
#       using BasePCLBase::input_;
#       using BasePCLBase::indices_;
#       using BasePCLBase::initCompute;
#       using BasePCLBase::deinitCompute;
# 
#       /** \brief A pointer to the spatial search object. */
#       KdTreePtr tree_;
# 
#       /** \brief The spatial cluster tolerance as a measure in the L2 Euclidean space. */
#       double cluster_tolerance_;
# 
#       /** \brief The minimum number of points that a cluster needs to contain in order to be considered valid (default = 1). */
#       int min_pts_per_cluster_;
# 
#       /** \brief The maximum number of points that a cluster needs to contain in order to be considered valid (default = MAXINT). */
#       int max_pts_per_cluster_;
# 
#       /** \brief The maximum number of labels we can find in this pointcloud (default = MAXINT)*/
#       unsigned int max_label_;
# 
#       /** \brief Class getName method. */
#       virtual std::string getClassName () const { return ("LabeledEuclideanClusterExtraction"); }
# 
#   };
# 
#   /** \brief Sort clusters method (for std::sort). 
#     * \ingroup segmentation
#     */
#   inline bool 
#     compareLabeledPointClusters (const pcl::PointIndices &a, const pcl::PointIndices &b)
#   {
#     return (a.indices.size () < b.indices.size ());
#   }
###

# extract_polygonal_prism_data.h
# namespace pcl
# {
#   /** \brief General purpose method for checking if a 3D point is inside or
#     * outside a given 2D polygon. 
#     * \note this method accepts any general 3D point that is projected onto the
#     * 2D polygon, but performs an internal XY projection of both the polygon and the point. 
#     * \param point a 3D point projected onto the same plane as the polygon
#     * \param polygon a polygon
#     * \ingroup segmentation
#     */
#   template <typename PointT> bool 
#   isPointIn2DPolygon (const PointT &point, const pcl::PointCloud<PointT> &polygon);
# 
#   /** \brief Check if a 2d point (X and Y coordinates considered only!) is
#     * inside or outside a given polygon. This method assumes that both the point
#     * and the polygon are projected onto the XY plane.
#     *
#     * \note (This is highly optimized code taken from http://www.visibone.com/inpoly/)
#     *       Copyright (c) 1995-1996 Galacticomm, Inc.  Freeware source code.
#     * \param point a 3D point projected onto the same plane as the polygon
#     * \param polygon a polygon
#     * \ingroup segmentation
#     */
#   template <typename PointT> bool 
#   isXYPointIn2DXYPolygon (const PointT &point, const pcl::PointCloud<PointT> &polygon);
# 
#   ////////////////////////////////////////////////////////////////////////////////////////////
#   /** \brief @b ExtractPolygonalPrismData uses a set of point indices that
#     * represent a planar model, and together with a given height, generates a 3D
#     * polygonal prism. The polygonal prism is then used to segment all points
#     * lying inside it.
#     *
#     * An example of its usage is to extract the data lying within a set of 3D
#     * boundaries (e.g., objects supported by a plane).
#     *
#     * \author Radu Bogdan Rusu
#     * \ingroup segmentation
#     */
#   template <typename PointT>
#   class ExtractPolygonalPrismData : public PCLBase<PointT>
#   {
#     using PCLBase<PointT>::input_;
#     using PCLBase<PointT>::indices_;
#     using PCLBase<PointT>::initCompute;
#     using PCLBase<PointT>::deinitCompute;
# 
#     public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       /** \brief Empty constructor. */
#       ExtractPolygonalPrismData () : planar_hull_ (), min_pts_hull_ (3), 
#                                      height_limit_min_ (0), height_limit_max_ (FLT_MAX),
#                                      vpx_ (0), vpy_ (0), vpz_ (0)
#       {};
# 
#       /** \brief Provide a pointer to the input planar hull dataset.
#         * \param[in] hull the input planar hull dataset
#         */
#       inline void 
#       setInputPlanarHull (const PointCloudConstPtr &hull) { planar_hull_ = hull; }
# 
#       /** \brief Get a pointer the input planar hull dataset. */
#       inline PointCloudConstPtr 
#       getInputPlanarHull () const { return (planar_hull_); }
# 
#       /** \brief Set the height limits. All points having distances to the
#         * model outside this interval will be discarded.
#         *
#         * \param[in] height_min the minimum allowed distance to the plane model value
#         * \param[in] height_max the maximum allowed distance to the plane model value
#         */
#       inline void
#       setHeightLimits (double height_min, double height_max)
#       {
#         height_limit_min_ = height_min;
#         height_limit_max_ = height_max;
#       }
# 
#       /** \brief Get the height limits (min/max) as set by the user. The
#         * default values are -FLT_MAX, FLT_MAX. 
#         * \param[out] height_min the resultant min height limit
#         * \param[out] height_max the resultant max height limit
#         */
#       inline void
#       getHeightLimits (double &height_min, double &height_max) const
#       {
#         height_min = height_limit_min_;
#         height_max = height_limit_max_;
#       }
# 
#       /** \brief Set the viewpoint.
#         * \param[in] vpx the X coordinate of the viewpoint
#         * \param[in] vpy the Y coordinate of the viewpoint
#         * \param[in] vpz the Z coordinate of the viewpoint
#         */
#       inline void
#       setViewPoint (float vpx, float vpy, float vpz)
#       {
#         vpx_ = vpx;
#         vpy_ = vpy;
#         vpz_ = vpz;
#       }
# 
#       /** \brief Get the viewpoint. */
#       inline void
#       getViewPoint (float &vpx, float &vpy, float &vpz) const
#       {
#         vpx = vpx_;
#         vpy = vpy_;
#         vpz = vpz_;
#       }
# 
#       /** \brief Cluster extraction in a PointCloud given by <setInputCloud (), setIndices ()>
#         * \param[out] output the resultant point indices that support the model found (inliers)
#         */
#       void 
#       segment (PointIndices &output);
# 
#     protected:
#       /** \brief A pointer to the input planar hull dataset. */
#       PointCloudConstPtr planar_hull_;
# 
#       /** \brief The minimum number of points needed on the convex hull. */
#       int min_pts_hull_;
# 
#       /** \brief The minimum allowed height (distance to the model) a point
#         * will be considered from. 
#         */
#       double height_limit_min_;
# 
#       /** \brief The maximum allowed height (distance to the model) a point
#         * will be considered from. 
#         */
#       double height_limit_max_;
# 
#       /** \brief Values describing the data acquisition viewpoint. Default: 0,0,0. */
#       float vpx_, vpy_, vpz_;
# 
#       /** \brief Class getName method. */
#       virtual std::string 
#       getClassName () const { return ("ExtractPolygonalPrismData"); }
#   };
# 
###

# organized_connected_component_segmentation.h
# namespace pcl
# {
#   /** \brief OrganizedConnectedComponentSegmentation allows connected
#     * components to be found within organized point cloud data, given a
#     * comparison function.  Given an input cloud and a comparator, it will
#     * output a PointCloud of labels, giving each connected component a unique
#     * id, along with a vector of PointIndices corresponding to each component.
#     * See OrganizedMultiPlaneSegmentation for an example application.
#     *
#     * \author Alex Trevor, Suat Gedikli
#     */
#   template <typename PointT, typename PointLT>
#   class OrganizedConnectedComponentSegmentation : public PCLBase<PointT>
#   {
#     using PCLBase<PointT>::input_;
#     using PCLBase<PointT>::indices_;
#     using PCLBase<PointT>::initCompute;
#     using PCLBase<PointT>::deinitCompute;
# 
#     public:
#       typedef typename pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
#       
#       typedef typename pcl::PointCloud<PointLT> PointCloudL;
#       typedef typename PointCloudL::Ptr PointCloudLPtr;
#       typedef typename PointCloudL::ConstPtr PointCloudLConstPtr;
# 
#       typedef typename pcl::Comparator<PointT> Comparator;
#       typedef typename Comparator::Ptr ComparatorPtr;
#       typedef typename Comparator::ConstPtr ComparatorConstPtr;
#       
#       /** \brief Constructor for OrganizedConnectedComponentSegmentation
#         * \param[in] compare A pointer to the comparator to be used for segmentation.  Must be an instance of pcl::Comparator.
#         */
#       OrganizedConnectedComponentSegmentation (const ComparatorConstPtr& compare)
#         : compare_ (compare)
#       {
#       }
# 
#       /** \brief Destructor for OrganizedConnectedComponentSegmentation. */
#       virtual
#       ~OrganizedConnectedComponentSegmentation ()
#       {
#       }
# 
#       /** \brief Provide a pointer to the comparator to be used for segmentation.
#         * \param[in] compare the comparator
#         */
#       void
#       setComparator (const ComparatorConstPtr& compare)
#       {
#         compare_ = compare;
#       }
#       
#       /** \brief Get the comparator.*/
#       ComparatorConstPtr
#       getComparator () const { return (compare_); }
# 
#       /** \brief Perform the connected component segmentation.
#         * \param[out] labels a PointCloud of labels: each connected component will have a unique id.
#         * \param[out] label_indices a vector of PointIndices corresponding to each label / component id.
#         */
#       void
#       segment (pcl::PointCloud<PointLT>& labels, std::vector<pcl::PointIndices>& label_indices) const;
#       
#       /** \brief Find the boundary points / contour of a connected component
#         * \param[in] start_idx the first (lowest) index of the connected component for which a boundary shoudl be returned
#         * \param[in] labels the Label cloud produced by segmentation
#         * \param[out] boundary_indices the indices of the boundary points for the label corresponding to start_idx
#         */
#       static void
#       findLabeledRegionBoundary (int start_idx, PointCloudLPtr labels, pcl::PointIndices& boundary_indices);      
#       
# 
#     protected:
#       ComparatorConstPtr compare_;
#       
#       inline unsigned
#       findRoot (const std::vector<unsigned>& runs, unsigned index) const
#       {
#         register unsigned idx = index;
#         while (runs[idx] != idx)
#           idx = runs[idx];
# 
#         return (idx);
#       }
###

# organized_multi_plane_segmentation.h
# namespace pcl
# {
#   /** \brief OrganizedMultiPlaneSegmentation finds all planes present in the
#     * input cloud, and outputs a vector of plane equations, as well as a vector
#     * of point clouds corresponding to the inliers of each detected plane.  Only
#     * planes with more than min_inliers points are detected.
#     * Templated on point type, normal type, and label type
#     *
#     * \author Alex Trevor, Suat Gedikli
#     */
#   template<typename PointT, typename PointNT, typename PointLT>
#   class OrganizedMultiPlaneSegmentation : public PCLBase<PointT>
#   {
#     using PCLBase<PointT>::input_;
#     using PCLBase<PointT>::indices_;
#     using PCLBase<PointT>::initCompute;
#     using PCLBase<PointT>::deinitCompute;
# 
#     public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
# 
#       typedef typename pcl::PointCloud<PointLT> PointCloudL;
#       typedef typename PointCloudL::Ptr PointCloudLPtr;
#       typedef typename PointCloudL::ConstPtr PointCloudLConstPtr;
# 
#       typedef typename pcl::PlaneCoefficientComparator<PointT, PointNT> PlaneComparator;
#       typedef typename PlaneComparator::Ptr PlaneComparatorPtr;
#       typedef typename PlaneComparator::ConstPtr PlaneComparatorConstPtr;
# 
#       typedef typename pcl::PlaneRefinementComparator<PointT, PointNT, PointLT> PlaneRefinementComparator;
#       typedef typename PlaneRefinementComparator::Ptr PlaneRefinementComparatorPtr;
#       typedef typename PlaneRefinementComparator::ConstPtr PlaneRefinementComparatorConstPtr;
# 
#       /** \brief Constructor for OrganizedMultiPlaneSegmentation. */
#       OrganizedMultiPlaneSegmentation () :
#         normals_ (), 
#         min_inliers_ (1000), 
#         angular_threshold_ (pcl::deg2rad (3.0)), 
#         distance_threshold_ (0.02),
#         maximum_curvature_ (0.001),
#         project_points_ (false), 
#         compare_ (new PlaneComparator ()), refinement_compare_ (new PlaneRefinementComparator ())
#       {
#       }
# 
#       /** \brief Destructor for OrganizedMultiPlaneSegmentation. */
#       virtual
#       ~OrganizedMultiPlaneSegmentation ()
#       {
#       }
# 
#       /** \brief Provide a pointer to the input normals.
#         * \param[in] normals the input normal cloud
#         */
#       inline void
#       setInputNormals (const PointCloudNConstPtr &normals) 
#       {
#         normals_ = normals;
#       }
# 
#       /** \brief Get the input normals. */
#       inline PointCloudNConstPtr
#       getInputNormals () const
#       {
#         return (normals_);
#       }
# 
#       /** \brief Set the minimum number of inliers required for a plane
#         * \param[in] min_inliers the minimum number of inliers required per plane
#         */
#       inline void
#       setMinInliers (unsigned min_inliers)
#       {
#         min_inliers_ = min_inliers;
#       }
# 
#       /** \brief Get the minimum number of inliers required per plane. */
#       inline unsigned
#       getMinInliers () const
#       {
#         return (min_inliers_);
#       }
# 
#       /** \brief Set the tolerance in radians for difference in normal direction between neighboring points, to be considered part of the same plane.
#         * \param[in] angular_threshold the tolerance in radians
#         */
#       inline void
#       setAngularThreshold (double angular_threshold)
#       {
#         angular_threshold_ = angular_threshold;
#       }
# 
#       /** \brief Get the angular threshold in radians for difference in normal direction between neighboring points, to be considered part of the same plane. */
#       inline double
#       getAngularThreshold () const
#       {
#         return (angular_threshold_);
#       }
# 
#       /** \brief Set the tolerance in meters for difference in perpendicular distance (d component of plane equation) to the plane between neighboring points, to be considered part of the same plane.
#         * \param[in] distance_threshold the tolerance in meters
#         */
#       inline void
#       setDistanceThreshold (double distance_threshold)
#       {
#         distance_threshold_ = distance_threshold;
#       }
# 
#       /** \brief Get the distance threshold in meters (d component of plane equation) between neighboring points, to be considered part of the same plane. */
#       inline double
#       getDistanceThreshold () const
#       {
#         return (distance_threshold_);
#       }
# 
#       /** \brief Set the maximum curvature allowed for a planar region.
#         * \param[in] maximum_curvature the maximum curvature
#         */
#       inline void
#       setMaximumCurvature (double maximum_curvature)
#       {
#         maximum_curvature_ = maximum_curvature;
#       }
# 
#       /** \brief Get the maximum curvature allowed for a planar region. */
#       inline double
#       getMaximumCurvature () const
#       {
#         return (maximum_curvature_);
#       }
# 
#       /** \brief Provide a pointer to the comparator to be used for segmentation.
#         * \param[in] compare A pointer to the comparator to be used for segmentation.
#         */
#       void
#       setComparator (const PlaneComparatorPtr& compare)
#       {
#         compare_ = compare;
#       }
# 
#       /** \brief Provide a pointer to the comparator to be used for refinement.
#         * \param[in] compare A pointer to the comparator to be used for refinement.
#         */
#       void
#       setRefinementComparator (const PlaneRefinementComparatorPtr& compare)
#       {
#         refinement_compare_ = compare;
#       }
# 
#       /** \brief Set whether or not to project boundary points to the plane, or leave them in the original 3D space.
#         * \param[in] project_points true if points should be projected, false if not.
#         */
#       void
#       setProjectPoints (bool project_points)
#       {
#         project_points_ = project_points;
#       }
# 
#       /** \brief Segmentation of all planes in a point cloud given by setInputCloud(), setIndices()
#         * \param[out] model_coefficients a vector of model_coefficients for each plane found in the input cloud
#         * \param[out] inlier_indices a vector of inliers for each detected plane
#         * \param[out] centroids a vector of centroids for each plane
#         * \param[out] covariances a vector of covariance matricies for the inliers of each plane
#         * \param[out] labels a point cloud for the connected component labels of each pixel
#         * \param[out] label_indices a vector of PointIndices for each labeled component
#         */
#       void
#       segment (std::vector<ModelCoefficients>& model_coefficients, 
#                std::vector<PointIndices>& inlier_indices,
#                std::vector<Eigen::Vector4f, Eigen::aligned_allocator<Eigen::Vector4f> >& centroids,
#                std::vector <Eigen::Matrix3f, Eigen::aligned_allocator<Eigen::Matrix3f> >& covariances,
#                pcl::PointCloud<PointLT>& labels, 
#                std::vector<pcl::PointIndices>& label_indices);
# 
#       /** \brief Segmentation of all planes in a point cloud given by setInputCloud(), setIndices()
#         * \param[out] model_coefficients a vector of model_coefficients for each plane found in the input cloud
#         * \param[out] inlier_indices a vector of inliers for each detected plane
#         */
#       void
#       segment (std::vector<ModelCoefficients>& model_coefficients, 
#                std::vector<PointIndices>& inlier_indices);
# 
#       /** \brief Segmentation of all planes in a point cloud given by setInputCloud(), setIndices()
#         * \param[out] regions a list of resultant planar polygonal regions
#         */
#       void
#       segment (std::vector<PlanarRegion<PointT>, Eigen::aligned_allocator<PlanarRegion<PointT> > >& regions);
#       
#       /** \brief Perform a segmentation, as well as an additional refinement step.  This helps with including points whose normals may not match neighboring points well, but may match the planar model well.
#         * \param[out] regions A list of regions generated by segmentation and refinement.
#         */
#       void
#       segmentAndRefine (std::vector<PlanarRegion<PointT>, Eigen::aligned_allocator<PlanarRegion<PointT> > >& regions);
# 
#       /** \brief Perform a segmentation, as well as additional refinement step.  Returns intermediate data structures for use in
#         * subsequent processing.
#         * \param[out] regions A vector of PlanarRegions generated by segmentation
#         * \param[out] model_coefficients A vector of model coefficients for each segmented plane
#         * \param[out] inlier_indices A vector of PointIndices, indicating the inliers to each segmented plane
#         * \param[out] labels A PointCloud<PointLT> corresponding to the resulting segmentation.
#         * \param[out] label_indices A vector of PointIndices for each label
#         * \param[out] boundary_indices A vector of PointIndices corresponding to the outer boundary / contour of each label
#         */
#       void
#       segmentAndRefine (std::vector<PlanarRegion<PointT>, Eigen::aligned_allocator<PlanarRegion<PointT> > >& regions,
#                         std::vector<ModelCoefficients>& model_coefficients,
#                         std::vector<PointIndices>& inlier_indices,
#                         PointCloudLPtr& labels,
#                         std::vector<pcl::PointIndices>& label_indices,
#                         std::vector<pcl::PointIndices>& boundary_indices);
#       
#       /** \brief Perform a refinement of an initial segmentation, by comparing points to adjacent regions detected by the initial segmentation.
#         * \param [in] model_coefficients The list of segmented model coefficients
#         * \param [in] inlier_indices The list of segmented inlier indices, corresponding to each model
#         * \param [in] centroids The list of centroids corresponding to each segmented plane
#         * \param [in] covariances The list of covariances corresponding to each segemented plane
#         * \param [in] labels The labels produced by the initial segmentation
#         * \param [in] label_indices The list of indices corresponding to each label
#         */
#       void
#       refine (std::vector<ModelCoefficients>& model_coefficients, 
#               std::vector<PointIndices>& inlier_indices,
#               std::vector<Eigen::Vector4f, Eigen::aligned_allocator<Eigen::Vector4f> >& centroids,
#               std::vector <Eigen::Matrix3f, Eigen::aligned_allocator<Eigen::Matrix3f> >& covariances,
#               PointCloudLPtr& labels,
#               std::vector<pcl::PointIndices>& label_indices);
# 
#     protected:
# 
#       /** \brief A pointer to the input normals */
#       PointCloudNConstPtr normals_;
# 
#       /** \brief The minimum number of inliers required for each plane. */
#       unsigned min_inliers_;
# 
#       /** \brief The tolerance in radians for difference in normal direction between neighboring points, to be considered part of the same plane. */
#       double angular_threshold_;
# 
#       /** \brief The tolerance in meters for difference in perpendicular distance (d component of plane equation) to the plane between neighboring points, to be considered part of the same plane. */
#       double distance_threshold_;
# 
#       /** \brief The tolerance for maximum curvature after fitting a plane.  Used to remove smooth, but non-planar regions. */
#       double maximum_curvature_;
# 
#       /** \brief Whether or not points should be projected to the plane, or left in the original 3D space. */
#       bool project_points_;
# 
#       /** \brief A comparator for comparing neighboring pixels' plane equations. */
#       PlaneComparatorPtr compare_;
# 
#       /** \brief A comparator for use on the refinement step.  Compares points to regions segmented in the first pass. */
#       PlaneRefinementComparatorPtr refinement_compare_;
# 
#       /** \brief Class getName method. */
#       virtual std::string
#       getClassName () const
#       {
#         return ("OrganizedMultiPlaneSegmentation");
#       }
#   };
# 
###

# planar_polygon_fusion.h
# namespace pcl
# {
#   /** \brief PlanarPolygonFusion takes a list of 2D planar polygons and
#     * attempts to reduce them to a minimum set that best represents the scene,
#     * based on various given comparators.
#     */
#   template <typename PointT>
#   class PlanarPolygonFusion
#   {
#     public:
#       /** \brief Constructor */
#       PlanarPolygonFusion () : regions_ () {}
#      
#       /** \brief Destructor */
#       virtual ~PlanarPolygonFusion () {}
# 
#       /** \brief Reset the state (clean the list of planar models). */
#       void 
#       reset ()
#       {
#         regions_.clear ();
#       }
#       
#       /** \brief Set the list of 2D planar polygons to refine.
#         * \param[in] input the list of 2D planar polygons to refine
#         */
#       void
#       addInputPolygons (const std::vector<PlanarRegion<PointT>, Eigen::aligned_allocator<PlanarRegion<PointT> > > &input)
#       {
#         int start = static_cast<int> (regions_.size ());
#         regions_.resize (regions_.size () + input.size ());
#         for(size_t i = 0; i < input.size (); i++)
#           regions_[start+i] = input[i];
#       }
# 
#     protected:
#       /** \brief Internal list of planar states. */
#       std::vector<pcl::PlanarRegion<PointT>, Eigen::aligned_allocator<pcl::PlanarRegion<PointT> > > regions_;
#   };
###

# planar_region.h
# namespace pcl
# {
#   /** \brief PlanarRegion represents a set of points that lie in a plane.  Inherits summary statistics about these points from Region3D, and  summary statistics of a 3D collection of points.
#     * \author Alex Trevor
#     */
#   template <typename PointT>
#   class PlanarRegion : public pcl::Region3D<PointT>, public pcl::PlanarPolygon<PointT>
#   {
#     protected:
#       using Region3D<PointT>::centroid_;
#       using Region3D<PointT>::covariance_; 
#       using Region3D<PointT>::count_;
#       using PlanarPolygon<PointT>::contour_;
#       using PlanarPolygon<PointT>::coefficients_;
# 
#     public:
#       /** \brief Empty constructor for PlanarRegion. */
#       PlanarRegion () : contour_labels_ ()
#       {}
# 
#       /** \brief Constructor for Planar region from a Region3D and a PlanarPolygon. 
#         * \param[in] region a Region3D for the input data
#         * \param[in] polygon a PlanarPolygon for the input region
#         */
#       PlanarRegion (const pcl::Region3D<PointT>& region, const pcl::PlanarPolygon<PointT>& polygon) :
#         contour_labels_ ()
#       {
#         centroid_ = region.centroid;
#         covariance_ = region.covariance;
#         count_ = region.count;
#         contour_ = polygon.contour;
#         coefficients_ = polygon.coefficients;
#       }
#       
#       /** \brief Destructor. */
#       virtual ~PlanarRegion () {}
# 
#       /** \brief Constructor for PlanarRegion.
#         * \param[in] centroid the centroid of the region.
#         * \param[in] covariance the covariance of the region.
#         * \param[in] count the number of points in the region.
#         * \param[in] contour the contour / boudnary for the region
#         * \param[in] coefficients the model coefficients (a,b,c,d) for the plane
#         */
#       PlanarRegion (const Eigen::Vector3f& centroid, const Eigen::Matrix3f& covariance, unsigned count,
#                     const typename pcl::PointCloud<PointT>::VectorType& contour,
#                     const Eigen::Vector4f& coefficients) :
#         contour_labels_ ()
#       {
#         centroid_ = centroid;
#         covariance_ = covariance;
#         count_ = count;
#         contour_ = contour;
#         coefficients_ = coefficients;
#       }
#       
#     private:
#       /** \brief The labels (good=true, bad=false) for whether or not this boundary was observed, 
#         * or was due to edge of frame / occlusion boundary. 
#         */
#       std::vector<bool> contour_labels_;
# 
#     public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#   };
###

# plane_refinement_comparator.h
# namespace pcl
# {
#   /** \brief PlaneRefinementComparator is a Comparator that operates on plane coefficients, 
#     * for use in planar segmentation.
#     * In conjunction with OrganizedConnectedComponentSegmentation, this allows planes to be segmented from organized data.
#     *
#     * \author Alex Trevor, Suat Gedikli
#     */
#   template<typename PointT, typename PointNT, typename PointLT>
#   class PlaneRefinementComparator: public PlaneCoefficientComparator<PointT, PointNT>
#   {
#     public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
# 
#       typedef typename pcl::PointCloud<PointLT> PointCloudL;
#       typedef typename PointCloudL::Ptr PointCloudLPtr;
#       typedef typename PointCloudL::ConstPtr PointCloudLConstPtr;
# 
#       typedef boost::shared_ptr<PlaneRefinementComparator<PointT, PointNT, PointLT> > Ptr;
#       typedef boost::shared_ptr<const PlaneRefinementComparator<PointT, PointNT, PointLT> > ConstPtr;
# 
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::input_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::normals_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::distance_threshold_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::plane_coeff_d_;
# 
# 
#       /** \brief Empty constructor for PlaneCoefficientComparator. */
#      PlaneRefinementComparator ()
#         : models_ ()
#         , labels_ ()
#         , refine_labels_ ()
#         , label_to_model_ ()
#         , depth_dependent_ (false)
#       {
#       }
# 
#       /** \brief Empty constructor for PlaneCoefficientComparator. 
#         * \param[in] models
#         * \param[in] refine_labels
#         */
#       PlaneRefinementComparator (boost::shared_ptr<std::vector<pcl::ModelCoefficients> >& models,
#                                  boost::shared_ptr<std::vector<bool> >& refine_labels)
#         : models_ (models)
#         , labels_ ()
#         , refine_labels_ (refine_labels)
#         , label_to_model_ ()
#         , depth_dependent_ (false)
#       {
#       }
# 
#       /** \brief Destructor for PlaneCoefficientComparator. */
#       virtual
#       ~PlaneRefinementComparator ()
#       {
#       }
# 
#       /** \brief Set the vector of model coefficients to which we will compare.
#         * \param[in] models a vector of model coefficients produced by the initial segmentation step.
#         */
#       void
#       setModelCoefficients (boost::shared_ptr<std::vector<pcl::ModelCoefficients> >& models)
#       {
#         models_ = models;
#       }
# 
#       /** \brief Set the vector of model coefficients to which we will compare.
#         * \param[in] models a vector of model coefficients produced by the initial segmentation step.
#         */
#       void
#       setModelCoefficients (std::vector<pcl::ModelCoefficients>& models)
#       {
#         models_ = boost::make_shared<std::vector<pcl::ModelCoefficients> >(models);
#       }
# 
#       /** \brief Set which labels should be refined.  This is a vector of bools 0-max_label, true if the label should be refined.
#         * \param[in] refine_labels A vector of bools 0-max_label, true if the label should be refined.
#         */
#       void
#       setRefineLabels (boost::shared_ptr<std::vector<bool> >& refine_labels)
#       {
#         refine_labels_ = refine_labels;
#       }
#       
#       /** \brief Set which labels should be refined.  This is a vector of bools 0-max_label, true if the label should be refined.
#         * \param[in] refine_labels A vector of bools 0-max_label, true if the label should be refined.
#         */
#       void
#       setRefineLabels (std::vector<bool>& refine_labels)
#       {
#         refine_labels_ = boost::make_shared<std::vector<bool> >(refine_labels);
#       }
# 
#       /** \brief A mapping from label to index in the vector of models, allowing the model coefficients of a label to be accessed.
#         * \param[in] label_to_model A vector of size max_label, with the index of each corresponding model in models
#         */
#       inline void
#       setLabelToModel (boost::shared_ptr<std::vector<int> >& label_to_model)
#       {
#         label_to_model_ = label_to_model;
#       }
#       
#       /** \brief A mapping from label to index in the vector of models, allowing the model coefficients of a label to be accessed.
#         * \param[in] label_to_model A vector of size max_label, with the index of each corresponding model in models
#         */
#       inline void
#       setLabelToModel (std::vector<int>& label_to_model)
#       {
#         label_to_model_ = boost::make_shared<std::vector<int> >(label_to_model);
#       }
# 
#       /** \brief Get the vector of model coefficients to which we will compare. */
#       inline boost::shared_ptr<std::vector<pcl::ModelCoefficients> >
#       getModelCoefficients () const
#       {
#         return (models_);
#       }
# 
#       /** \brief ...
#         * \param[in] labels
#         */
#       inline void
#       setLabels (PointCloudLPtr& labels)
#       {
#         labels_ = labels;
#       }
# 
#       /** \brief Compare two neighboring points
#         * \param[in] idx1 The index of the first point.
#         * \param[in] idx2 The index of the second point.
#         */
#       virtual bool
#       compare (int idx1, int idx2) const
#       {
#         int current_label = labels_->points[idx1].label;
#         int next_label = labels_->points[idx2].label;
# 
#         if (!((*refine_labels_)[current_label] && !(*refine_labels_)[next_label]))
#           return (false);
#         
#         const pcl::ModelCoefficients& model_coeff = (*models_)[(*label_to_model_)[current_label]];
#         
#         PointT pt = input_->points[idx2];
#         double ptp_dist = fabs (model_coeff.values[0] * pt.x + 
#                                 model_coeff.values[1] * pt.y + 
#                                 model_coeff.values[2] * pt.z +
#                                 model_coeff.values[3]);
#         
#         // depth dependent
#         float threshold = distance_threshold_;
#         if (depth_dependent_)
#         {
#           //Eigen::Vector4f origin = input_->sensor_origin_;
#           Eigen::Vector3f vec = input_->points[idx1].getVector3fMap ();// - origin.head<3> ();
#           
#           float z = vec.dot (z_axis_);
#           threshold *= z * z;
#         }
#         
#         return (ptp_dist < threshold);
#       }
# 
#     protected:
#       boost::shared_ptr<std::vector<pcl::ModelCoefficients> > models_;
#       PointCloudLPtr labels_;
#       boost::shared_ptr<std::vector<bool> > refine_labels_;
#       boost::shared_ptr<std::vector<int> > label_to_model_;
#       bool depth_dependent_;
#       using PlaneCoefficientComparator<PointT, PointNT>::z_axis_;
###

# region_3d.h
# namespace pcl
# {
#   /** \brief Region3D represents summary statistics of a 3D collection of points.
#     * \author Alex Trevor
#     */
#   template <typename PointT>
#   class Region3D
#   {
#     public:
#       /** \brief Empty constructor for Region3D. */
#       Region3D () : centroid_ (Eigen::Vector3f::Zero ()), covariance_ (Eigen::Matrix3f::Identity ()), count_ (0)
#       {
#       }
#       
#       /** \brief Constructor for Region3D. 
#         * \param[in] centroid The centroid of the region.
#         * \param[in] covariance The covariance of the region.
#         * \param[in] count The number of points in the region.
#         */
#       Region3D (Eigen::Vector3f& centroid, Eigen::Matrix3f& covariance, unsigned count) 
#         : centroid_ (centroid), covariance_ (covariance), count_ (count)
#       {
#       }
#      
#       /** \brief Destructor. */
#       virtual ~Region3D () {}
# 
#       /** \brief Get the centroid of the region. */
#       inline Eigen::Vector3f 
#       getCentroid () const
#       {
#         return (centroid_);
#       }
#       
#       /** \brief Get the covariance of the region. */
#       inline Eigen::Matrix3f
#       getCovariance () const
#       {
#         return (covariance_);
#       }
#       
#       /** \brief Get the number of points in the region. */
#       unsigned
#       getCount () const
#       {
#         return (count_);
#       }
# 
#     protected:
#       /** \brief The centroid of the region. */
#       Eigen::Vector3f centroid_;
#       
#       /** \brief The covariance of the region. */
#       Eigen::Matrix3f covariance_;
#       
#       /** \brief The number of points in the region. */
#       unsigned count_;
# 
#     public:
#       EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#   };
###

# rgb_plane_coefficient_comparator.h
# namespace pcl
# {
#   /** \brief RGBPlaneCoefficientComparator is a Comparator that operates on plane coefficients, 
#     * for use in planar segmentation.  Also takes into account RGB, so we can segmented different colored co-planar regions.
#     * In conjunction with OrganizedConnectedComponentSegmentation, this allows planes to be segmented from organized data.
#     *
#     * \author Alex Trevor
#     */
#   template<typename PointT, typename PointNT>
#   class RGBPlaneCoefficientComparator: public PlaneCoefficientComparator<PointT, PointNT>
#   {
#     public:
#       typedef typename Comparator<PointT>::PointCloud PointCloud;
#       typedef typename Comparator<PointT>::PointCloudConstPtr PointCloudConstPtr;
#       
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#       
#       typedef boost::shared_ptr<RGBPlaneCoefficientComparator<PointT, PointNT> > Ptr;
#       typedef boost::shared_ptr<const RGBPlaneCoefficientComparator<PointT, PointNT> > ConstPtr;
# 
#       using pcl::Comparator<PointT>::input_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::normals_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::angular_threshold_;
#       using pcl::PlaneCoefficientComparator<PointT, PointNT>::distance_threshold_;
# 
#       /** \brief Empty constructor for RGBPlaneCoefficientComparator. */
#       RGBPlaneCoefficientComparator ()
#         : color_threshold_ (50.0f)
#       {
#       }
# 
#       /** \brief Constructor for RGBPlaneCoefficientComparator.
#         * \param[in] plane_coeff_d a reference to a vector of d coefficients of plane equations.  Must be the same size as the input cloud and input normals.  a, b, and c coefficients are in the input normals.
#         */
#       RGBPlaneCoefficientComparator (boost::shared_ptr<std::vector<float> >& plane_coeff_d) 
#         : PlaneCoefficientComparator<PointT, PointNT> (plane_coeff_d), color_threshold_ (50.0f)
#       {
#       }
#       
#       /** \brief Destructor for RGBPlaneCoefficientComparator. */
#       virtual
#       ~RGBPlaneCoefficientComparator ()
#       {
#       }
# 
#       /** \brief Set the tolerance in color space between neighboring points, to be considered part of the same plane.
#         * \param[in] color_threshold The distance in color space
#         */
#       inline void
#       setColorThreshold (float color_threshold)
#       {
#         color_threshold_ = color_threshold * color_threshold;
#       }
# 
#       /** \brief Get the color threshold between neighboring points, to be considered part of the same plane. */
#       inline float
#       getColorThreshold () const
#       {
#         return (color_threshold_);
#       }
# 
#       /** \brief Compare two neighboring points, by using normal information, euclidean distance, and color information.
#         * \param[in] idx1 The index of the first point.
#         * \param[in] idx2 The index of the second point.
#         */
#       bool
#       compare (int idx1, int idx2) const
#       {
#         float dx = input_->points[idx1].x - input_->points[idx2].x;
#         float dy = input_->points[idx1].y - input_->points[idx2].y;
#         float dz = input_->points[idx1].z - input_->points[idx2].z;
#         float dist = sqrtf (dx*dx + dy*dy + dz*dz);
#         int dr = input_->points[idx1].r - input_->points[idx2].r;
#         int dg = input_->points[idx1].g - input_->points[idx2].g;
#         int db = input_->points[idx1].b - input_->points[idx2].b;
#         //Note: This is not the best metric for color comparisons, we should probably use HSV space.
#         float color_dist = static_cast<float> (dr*dr + dg*dg + db*db);
#         return ( (dist < distance_threshold_)
#                  && (normals_->points[idx1].getNormalVector3fMap ().dot (normals_->points[idx2].getNormalVector3fMap () ) > angular_threshold_ )
#                  && (color_dist < color_threshold_));
#       }
#       
#     protected:
#       float color_threshold_;
#   };
# 
###

# sac_segmentation.h
# namespace pcl
# {
#   /** \brief @b SACSegmentation represents the Nodelet segmentation class for
#     * Sample Consensus methods and models, in the sense that it just creates a
#     * Nodelet wrapper for generic-purpose SAC-based segmentation.
#     * \author Radu Bogdan Rusu
#     * \ingroup segmentation
#     */
#   template <typename PointT>
#   class SACSegmentation : public PCLBase<PointT>
#   {
#     using PCLBase<PointT>::initCompute;
#     using PCLBase<PointT>::deinitCompute;
# 
#      public:
#       using PCLBase<PointT>::input_;
#       using PCLBase<PointT>::indices_;
# 
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
#       typedef typename pcl::search::Search<PointT>::Ptr SearchPtr;
# 
#       typedef typename SampleConsensus<PointT>::Ptr SampleConsensusPtr;
#       typedef typename SampleConsensusModel<PointT>::Ptr SampleConsensusModelPtr;
# 
#       /** \brief Empty constructor. */
#       SACSegmentation () :  model_ (), sac_ (), model_type_ (-1), method_type_ (0), 
#                             threshold_ (0), optimize_coefficients_ (true), 
#                             radius_min_ (-std::numeric_limits<double>::max()), radius_max_ (std::numeric_limits<double>::max()), samples_radius_ (0.0), eps_angle_ (0.0),
#                             axis_ (Eigen::Vector3f::Zero ()), max_iterations_ (50), probability_ (0.99)
#       {
#         //srand ((unsigned)time (0)); // set a random seed
#       }
# 
#       /** \brief Empty destructor. */
#       virtual ~SACSegmentation () { /*srv_.reset ();*/ };
# 
#       /** \brief The type of model to use (user given parameter).
#         * \param[in] model the model type (check \a model_types.h)
#         */
#       inline void 
#       setModelType (int model) { model_type_ = model; }
# 
#       /** \brief Get the type of SAC model used. */
#       inline int 
#       getModelType () const { return (model_type_); }
# 
#       /** \brief Get a pointer to the SAC method used. */
#       inline SampleConsensusPtr 
#       getMethod () const { return (sac_); }
# 
#       /** \brief Get a pointer to the SAC model used. */
#       inline SampleConsensusModelPtr 
#       getModel () const { return (model_); }
# 
#       /** \brief The type of sample consensus method to use (user given parameter).
#         * \param[in] method the method type (check \a method_types.h)
#         */
#       inline void 
#       setMethodType (int method) { method_type_ = method; }
# 
#       /** \brief Get the type of sample consensus method used. */
#       inline int 
#       getMethodType () const { return (method_type_); }
# 
#       /** \brief Distance to the model threshold (user given parameter).
#         * \param[in] threshold the distance threshold to use
#         */
#       inline void 
#       setDistanceThreshold (double threshold) { threshold_ = threshold; }
# 
#       /** \brief Get the distance to the model threshold. */
#       inline double 
#       getDistanceThreshold () const { return (threshold_); }
# 
#       /** \brief Set the maximum number of iterations before giving up.
#         * \param[in] max_iterations the maximum number of iterations the sample consensus method will run
#         */
#       inline void 
#       setMaxIterations (int max_iterations) { max_iterations_ = max_iterations; }
# 
#       /** \brief Get maximum number of iterations before giving up. */
#       inline int 
#       getMaxIterations () const { return (max_iterations_); }
# 
#       /** \brief Set the probability of choosing at least one sample free from outliers.
#         * \param[in] probability the model fitting probability
#         */
#       inline void 
#       setProbability (double probability) { probability_ = probability; }
# 
#       /** \brief Get the probability of choosing at least one sample free from outliers. */
#       inline double 
#       getProbability () const { return (probability_); }
# 
#       /** \brief Set to true if a coefficient refinement is required.
#         * \param[in] optimize true for enabling model coefficient refinement, false otherwise
#         */
#       inline void 
#       setOptimizeCoefficients (bool optimize) { optimize_coefficients_ = optimize; }
# 
#       /** \brief Get the coefficient refinement internal flag. */
#       inline bool 
#       getOptimizeCoefficients () const { return (optimize_coefficients_); }
# 
#       /** \brief Set the minimum and maximum allowable radius limits for the model (applicable to models that estimate
#         * a radius)
#         * \param[in] min_radius the minimum radius model
#         * \param[in] max_radius the maximum radius model
#         */
#       inline void
#       setRadiusLimits (const double &min_radius, const double &max_radius)
#       {
#         radius_min_ = min_radius;
#         radius_max_ = max_radius;
#       }
# 
#       /** \brief Get the minimum and maximum allowable radius limits for the model as set by the user.
#         * \param[out] min_radius the resultant minimum radius model
#         * \param[out] max_radius the resultant maximum radius model
#         */
#       inline void
#       getRadiusLimits (double &min_radius, double &max_radius)
#       {
#         min_radius = radius_min_;
#         max_radius = radius_max_;
#       }
# 
#       /** \brief Set the maximum distance allowed when drawing random samples
#         * \param[in] radius the maximum distance (L2 norm)
#         */
#       inline void
#       setSamplesMaxDist (const double &radius, SearchPtr search)
#       {
#         samples_radius_ = radius;
#         samples_radius_search_ = search;
#       }
# 
#       /** \brief Get maximum distance allowed when drawing random samples
#         *
#         * \param[out] radius the maximum distance (L2 norm)
#         */
#       inline void
#       getSamplesMaxDist (double &radius)
#       {
#         radius = samples_radius_;
#       }
# 
#       /** \brief Set the axis along which we need to search for a model perpendicular to.
#         * \param[in] ax the axis along which we need to search for a model perpendicular to
#         */
#       inline void 
#       setAxis (const Eigen::Vector3f &ax) { axis_ = ax; }
# 
#       /** \brief Get the axis along which we need to search for a model perpendicular to. */
#       inline Eigen::Vector3f 
#       getAxis () const { return (axis_); }
# 
#       /** \brief Set the angle epsilon (delta) threshold.
#         * \param[in] ea the maximum allowed difference between the model normal and the given axis in radians.
#         */
#       inline void 
#       setEpsAngle (double ea) { eps_angle_ = ea; }
# 
#       /** \brief Get the epsilon (delta) model angle threshold in radians. */
#       inline double 
#       getEpsAngle () const { return (eps_angle_); }
# 
#       /** \brief Base method for segmentation of a model in a PointCloud given by <setInputCloud (), setIndices ()>
#         * \param[in] inliers the resultant point indices that support the model found (inliers)
#         * \param[out] model_coefficients the resultant model coefficients
#         */
#       virtual void 
#       segment (PointIndices &inliers, ModelCoefficients &model_coefficients);
# 
#     protected:
#       /** \brief Initialize the Sample Consensus model and set its parameters.
#         * \param[in] model_type the type of SAC model that is to be used
#         */
#       virtual bool 
#       initSACModel (const int model_type);
# 
#       /** \brief Initialize the Sample Consensus method and set its parameters.
#         * \param[in] method_type the type of SAC method to be used
#         */
#       virtual void 
#       initSAC (const int method_type);
# 
#       /** \brief The model that needs to be segmented. */
#       SampleConsensusModelPtr model_;
# 
#       /** \brief The sample consensus segmentation method. */
#       SampleConsensusPtr sac_;
# 
#       /** \brief The type of model to use (user given parameter). */
#       int model_type_;
# 
#       /** \brief The type of sample consensus method to use (user given parameter). */
#       int method_type_;
# 
#       /** \brief Distance to the model threshold (user given parameter). */
#       double threshold_;
# 
#       /** \brief Set to true if a coefficient refinement is required. */
#       bool optimize_coefficients_;
# 
#       /** \brief The minimum and maximum radius limits for the model. Applicable to all models that estimate a radius. */
#       double radius_min_, radius_max_;
# 
#       /** \brief The maximum distance of subsequent samples from the first (radius search) */
#       double samples_radius_;
# 
#       /** \brief The search object for picking subsequent samples using radius search */
#       SearchPtr samples_radius_search_;
# 
#       /** \brief The maximum allowed difference between the model normal and the given axis. */
#       double eps_angle_;
# 
#       /** \brief The axis along which we need to search for a model perpendicular to. */
#       Eigen::Vector3f axis_;
# 
#       /** \brief Maximum number of iterations before giving up (user given parameter). */
#       int max_iterations_;
# 
#       /** \brief Desired probability of choosing at least one sample free from outliers (user given parameter). */
#       double probability_;
# 
#       /** \brief Class get name method. */
#       virtual std::string 
#       getClassName () const { return ("SACSegmentation"); }
#   };
# 
#   /** \brief @b SACSegmentationFromNormals represents the PCL nodelet segmentation class for Sample Consensus methods and
#     * models that require the use of surface normals for estimation.
#     * \ingroup segmentation
#     */
#   template <typename PointT, typename PointNT>
#   class SACSegmentationFromNormals: public SACSegmentation<PointT>
#   {
#     using SACSegmentation<PointT>::model_;
#     using SACSegmentation<PointT>::model_type_;
#     using SACSegmentation<PointT>::radius_min_;
#     using SACSegmentation<PointT>::radius_max_;
#     using SACSegmentation<PointT>::eps_angle_;
#     using SACSegmentation<PointT>::axis_;
# 
#     public:
#       using PCLBase<PointT>::input_;
#       using PCLBase<PointT>::indices_;
# 
#       typedef typename SACSegmentation<PointT>::PointCloud PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef typename pcl::PointCloud<PointNT> PointCloudN;
#       typedef typename PointCloudN::Ptr PointCloudNPtr;
#       typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
# 
#       typedef typename SampleConsensus<PointT>::Ptr SampleConsensusPtr;
#       typedef typename SampleConsensusModel<PointT>::Ptr SampleConsensusModelPtr;
#       typedef typename SampleConsensusModelFromNormals<PointT, PointNT>::Ptr SampleConsensusModelFromNormalsPtr;
# 
#       /** \brief Empty constructor. */
#       SACSegmentationFromNormals () : 
#         normals_ (), 
#         distance_weight_ (0.1), 
#         distance_from_origin_ (0), 
#         min_angle_ (), 
#         max_angle_ ()
#       {};
# 
#       /** \brief Provide a pointer to the input dataset that contains the point normals of 
#         * the XYZ dataset.
#         * \param[in] normals the const boost shared pointer to a PointCloud message
#         */
#       inline void 
#       setInputNormals (const PointCloudNConstPtr &normals) { normals_ = normals; }
# 
#       /** \brief Get a pointer to the normals of the input XYZ point cloud dataset. */
#       inline PointCloudNConstPtr 
#       getInputNormals () const { return (normals_); }
# 
#       /** \brief Set the relative weight (between 0 and 1) to give to the angular 
#         * distance (0 to pi/2) between point normals and the plane normal.
#         * \param[in] distance_weight the distance/angular weight
#         */
#       inline void 
#       setNormalDistanceWeight (double distance_weight) { distance_weight_ = distance_weight; }
# 
#       /** \brief Get the relative weight (between 0 and 1) to give to the angular distance (0 to pi/2) between point
#         * normals and the plane normal. */
#       inline double 
#       getNormalDistanceWeight () const { return (distance_weight_); }
# 
#       /** \brief Set the minimum opning angle for a cone model.
#         * \param oa the opening angle which we need minumum to validate a cone model.
#         */
#       inline void
#       setMinMaxOpeningAngle (const double &min_angle, const double &max_angle)
#       {
#         min_angle_ = min_angle;
#         max_angle_ = max_angle;
#       }
#  
#       /** \brief Get the opening angle which we need minumum to validate a cone model. */
#       inline void
#       getMinMaxOpeningAngle (double &min_angle, double &max_angle)
#       {
#         min_angle = min_angle_;
#         max_angle = max_angle_;
#       }
# 
#       /** \brief Set the distance we expect a plane model to be from the origin
#         * \param[in] d distance from the template plane modl to the origin
#         */
#       inline void
#       setDistanceFromOrigin (const double d) { distance_from_origin_ = d; }
# 
#       /** \brief Get the distance of a plane model from the origin. */
#       inline double
#       getDistanceFromOrigin () const { return (distance_from_origin_); }
# 
#     protected:
#       /** \brief A pointer to the input dataset that contains the point normals of the XYZ dataset. */
#       PointCloudNConstPtr normals_;
# 
#       /** \brief The relative weight (between 0 and 1) to give to the angular
#         * distance (0 to pi/2) between point normals and the plane normal. 
#         */
#       double distance_weight_;
# 
#       /** \brief The distance from the template plane to the origin. */
#       double distance_from_origin_;
# 
#       /** \brief The minimum and maximum allowed opening angle of valid cone model. */
#       double min_angle_;
#       double max_angle_;
# 
#       /** \brief Initialize the Sample Consensus model and set its parameters.
#         * \param[in] model_type the type of SAC model that is to be used
#         */
#       virtual bool 
#       initSACModel (const int model_type);
# 
#       /** \brief Class get name method. */
#       virtual std::string 
#       getClassName () const { return ("SACSegmentationFromNormals"); }
#   };
###

# segment_differences.h
# namespace pcl
# /** \brief Obtain the difference between two aligned point clouds as another point cloud, given a distance threshold.
#   * \param src the input point cloud source
#   * \param tgt the input point cloud target we need to obtain the difference against
#   * \param threshold the distance threshold (tolerance) for point correspondences. (e.g., check if f a point p1 from 
#   * src has a correspondence > threshold than a point p2 from tgt)
#   * \param tree the spatial locator (e.g., kd-tree) used for nearest neighbors searching built over \a tgt
#   * \param output the resultant output point cloud difference
#   * \ingroup segmentation
#   */
# template <typename PointT> 
# void getPointCloudDifference (
#     const pcl::PointCloud<PointT> &src, const pcl::PointCloud<PointT> &tgt, 
#     double threshold, const boost::shared_ptr<pcl::search::Search<PointT> > &tree,
#     pcl::PointCloud<PointT> &output);

# /** \brief @b SegmentDifferences obtains the difference between two spatially
#   * aligned point clouds and returns the difference between them for a maximum
#   * given distance threshold.
#   * \author Radu Bogdan Rusu
#   * \ingroup segmentation
#   */
# template <typename PointT>
# class SegmentDifferences: public PCLBase<PointT>
#     typedef PCLBase<PointT> BasePCLBase;
# 
#     public:
#       typedef pcl::PointCloud<PointT> PointCloud;
#       typedef typename PointCloud::Ptr PointCloudPtr;
#       typedef typename PointCloud::ConstPtr PointCloudConstPtr;
# 
#       typedef typename pcl::search::Search<PointT> KdTree;
#       typedef typename pcl::search::Search<PointT>::Ptr KdTreePtr;
# 
#       typedef PointIndices::Ptr PointIndicesPtr;
#       typedef PointIndices::ConstPtr PointIndicesConstPtr;
# 
#       /** \brief Empty constructor. */
#       SegmentDifferences ()
# 
#       /** \brief Provide a pointer to the target dataset against which we
#         * compare the input cloud given in setInputCloud
#         * \param cloud the target PointCloud dataset
#       inline void setTargetCloud (const PointCloudConstPtr &cloud)
# 
#       /** \brief Get a pointer to the input target point cloud dataset. */
#       inline PointCloudConstPtr const getTargetCloud ()
#       /** \brief Provide a pointer to the search object.
#         * \param tree a pointer to the spatial search object.
#       inline void setSearchMethod (const KdTreePtr &tree)
#       /** \brief Get a pointer to the search method used. */
#       inline KdTreePtr getSearchMethod ()
#       /** \brief Set the maximum distance tolerance (squared) between corresponding
#         * points in the two input datasets.
#         * \param sqr_threshold the squared distance tolerance as a measure in L2 Euclidean space
#       inline void setDistanceThreshold (double sqr_threshold)
#       /** \brief Get the squared distance tolerance between corresponding points as a
#         * measure in the L2 Euclidean space.
#       inline double getDistanceThreshold ()
# 
#       /** \brief Segment differences between two input point clouds.
#         * \param output the resultant difference between the two point clouds as a PointCloud
#         */
#       void segment (PointCloud &output);
#       protected:
#       // Members derived from the base class
#       using BasePCLBase::input_;
#       using BasePCLBase::indices_;
#       using BasePCLBase::initCompute;
#       using BasePCLBase::deinitCompute;
#       /** \brief A pointer to the spatial search object. */
#       KdTreePtr tree_;
#       /** \brief The input target point cloud dataset. */
#       PointCloudConstPtr target_;
#       /** \brief The distance tolerance (squared) as a measure in the L2
#         * Euclidean space between corresponding points. 
#         */
#       double distance_threshold_;
#       /** \brief Class getName method. */
#       virtual std::string getClassName () const { return ("SegmentDifferences"); }
###

###############################################################################
# Enum
###############################################################################

###############################################################################
# Activation
###############################################################################
