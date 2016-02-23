from libcpp.string cimport string
from libcpp cimport bool
from libcpp.vector cimport vector

# main
cimport pcl_defs as cpp

from boost_shared_ptr cimport shared_ptr

cimport eigen as eigen3

###############################################################################
# Types
###############################################################################

### base class ###

# conditional_removal.h
# template<typename PointT>
# class ComparisonBase
cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
    cdef cppclass ComparisonBase[T]:
        ComparisonBase()
        # public:
        # ctypedef boost::shared_ptr<ComparisonBase<PointT> > Ptr;
        # ctypedef boost::shared_ptr<const ComparisonBase<PointT> > ConstPtr;
        ##
        # brief Return if the comparison is capable.
        bool isCapable ()
        # /** \brief Evaluate function. */
        # virtual bool evaluate (const PointT &point) const = 0;
###

# conditional_removal.h
# template<typename PointT>
# class ConditionBase
cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
    cdef cppclass ConditionBase[T]:
        ConditionBase ()
        # public:
        # ctypedef typename pcl::ComparisonBase<PointT> ComparisonBase;
        # ctypedef typename ComparisonBase::Ptr ComparisonBasePtr;
        # ctypedef typename ComparisonBase::ConstPtr ComparisonBaseConstPtr;
        # ctypedef boost::shared_ptr<ConditionBase<PointT> > Ptr;
        # ctypedef boost::shared_ptr<const ConditionBase<PointT> > ConstPtr;
        # void addComparison (ComparisonBaseConstPtr comparison);
        # void addCondition (Ptr condition);
        bool isCapable ()
###

# filter.h
# template<typename PointT>
# class Filter : public PCLBase<PointT>
cdef extern from "pcl/filters/filter.h" namespace "pcl":
    cdef cppclass Filter[T](cpp.PCLBase[T]):
        Filter()
        # public:
        # using PCLBase<PointT>::indices_;
        # using PCLBase<PointT>::input_;
        # ctypedef boost::shared_ptr< Filter<PointT> > Ptr;
        # ctypedef boost::shared_ptr< const Filter<PointT> > ConstPtr;
        # ctypedef pcl::PointCloud<PointT> PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # /** \brief Get the point indices being removed */
        cpp.IndicesPtr_t getRemovedIndices ()
        # /** \brief Calls the filtering method and returns the filtered dataset in output.
        #   * \param[out] output the resultant filtered point cloud dataset
        #   */
        void filter (cpp.PointCloud[T] &output)

# template<>
# class PCL_EXPORTS Filter<sensor_msgs::PointCloud2> : public PCLBase<sensor_msgs::PointCloud2>
#     public:
#       typedef sensor_msgs::PointCloud2 PointCloud2;
#       typedef PointCloud2::Ptr PointCloud2Ptr;
#       typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#       /** \brief Empty constructor. 
#         * \param[in] extract_removed_indices set to true if the filtered data indices should be saved in a 
#         * separate list. Default: false.
#       Filter (bool extract_removed_indices = false)
#       /** \brief Get the point indices being removed */
#       IndicesConstPtr const getRemovedIndices ()
#       /** \brief Calls the filtering method and returns the filtered dataset in output.
#         * \param[out] output the resultant filtered point cloud dataset
#       void filter (PointCloud2 &output);
###

# filter_indices.h
# template<typename PointT>
# class FilterIndices : public Filter<PointT>
cdef extern from "pcl/filters/filter_indices.h" namespace "pcl":
    cdef cppclass FilterIndices[T](Filter[T]):
        FilterIndices()
        # public:
        # ctypedef pcl::PointCloud<PointT> PointCloud;
        void filter (cpp.PointCloud[T] &output)
        # brief Calls the filtering method and returns the filtered point cloud indices.
        # param[out] indices the resultant filtered point cloud indices
        void filter (vector[int] &indices)
        # \brief Set whether the regular conditions for points filtering should apply, or the inverted conditions.
        # \param[in] negative false = normal filter behavior (default), true = inverted behavior.
        void setNegative (bool negative)
        # \brief Get whether the regular conditions for points filtering should apply, or the inverted conditions.
        # \return The value of the internal \a negative_ parameter; false = normal filter behavior (default), true = inverted behavior.
        bool getNegative ()
        # \brief Set whether the filtered points should be kept and set to the value given through \a setUserFilterValue (default: NaN),
        # or removed from the PointCloud, thus potentially breaking its organized structure.
        # \param[in] keep_organized false = remove points (default), true = redefine points, keep structure.
        void setKeepOrganized (bool keep_organized)
        # brief Get whether the filtered points should be kept and set to the value given through \a setUserFilterValue (default = NaN),
        # or removed from the PointCloud, thus potentially breaking its organized structure.
        # return The value of the internal \a keep_organized_ parameter; false = remove points (default), true = redefine points, keep structure.
        bool getKeepOrganized ()
        # brief Provide a value that the filtered points should be set to instead of removing them.
        # Used in conjunction with \a setKeepOrganized ().
        # param[in] value the user given value that the filtered point dimensions should be set to (default = NaN).
        void setUserFilterValue (float value)
        # brief Get the point indices being removed
        # return The value of the internal \a negative_ parameter; false = normal filter behavior (default), true = inverted behavior.
        cpp.IndicesPtr_t getRemovedIndices ()

# template<>
# class PCL_EXPORTS FilterIndices<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#     public:
#       typedef sensor_msgs::PointCloud2 PointCloud2;
#       /** \brief Constructor.
#         * \param[in] extract_removed_indices Set to true if you want to extract the indices of points being removed (default = false).
#       FilterIndices (bool extract_removed_indices = false) :
#       /** \brief Empty virtual destructor. */
#       virtual ~FilterIndices ()
#       virtual void filter (PointCloud2 &output)
#       /** \brief Calls the filtering method and returns the filtered point cloud indices.
#         * \param[out] indices the resultant filtered point cloud indices
#       void filter (vector[int] &indices)
#       /** \brief Set whether the regular conditions for points filtering should apply, or the inverted conditions.
#         * \param[in] negative false = normal filter behavior (default), true = inverted behavior.
#       void setNegative (bool negative)
#       /** \brief Get whether the regular conditions for points filtering should apply, or the inverted conditions.
#         * \return The value of the internal \a negative_ parameter; false = normal filter behavior (default), true = inverted behavior.
#       bool getNegative ()
#       /** \brief Set whether the filtered points should be kept and set to the value given through \a setUserFilterValue (default: NaN),
#         * or removed from the PointCloud, thus potentially breaking its organized structure.
#         * \param[in] keep_organized false = remove points (default), true = redefine points, keep structure.
#       void setKeepOrganized (bool keep_organized)
#       /** \brief Get whether the filtered points should be kept and set to the value given through \a setUserFilterValue (default = NaN),
#         * or removed from the PointCloud, thus potentially breaking its organized structure.
#         * \return The value of the internal \a keep_organized_ parameter; false = remove points (default), true = redefine points, keep structure.
#       bool getKeepOrganized ()
#       /** \brief Provide a value that the filtered points should be set to instead of removing them.
#         * Used in conjunction with \a setKeepOrganized ().
#         * \param[in] value the user given value that the filtered point dimensions should be set to (default = NaN).
#       void setUserFilterValue (float value)
#       /** \brief Get the point indices being removed
#         * \return The value of the internal \a negative_ parameter; false = normal filter behavior (default), true = inverted behavior.
#       IndicesConstPtr const getRemovedIndices ()
###

### Inheritance class ###

# approximate_voxel_grid.h
# NG ###
# template <typename PointT>
# struct xNdCopyEigenPointFunctor
# cdef extern from "pcl/filters/approximate_voxel_grid.h" namespace "pcl":
#     cdef struct xNdCopyEigenPointFunctor[T]:
#         xNdCopyEigenPointFunctor()
#         # ctypedef typename traits::POD<PointT>::type Pod;
#         # xNdCopyEigenPointFunctor (const Eigen::VectorXf &p1, PointT &p2)
#         # template<typename Key> void operator() ()
# 
# # template <typename PointT>
# # struct xNdCopyPointEigenFunctor
# cdef extern from "pcl/filters/approximate_voxel_grid.h" namespace "pcl":
#     cdef struct xNdCopyPointEigenFunctor[T]:
#         xNdCopyPointEigenFunctor()
#         # ctypedef typename traits::POD<PointT>::type Pod;
#         # xNdCopyPointEigenFunctor (const PointT &p1, Eigen::VectorXf &p2)
#         # template<typename Key> void operator() ()
# NG ###

# template <typename PointT>
# class ApproximateVoxelGrid: public Filter<PointT>
cdef extern from "pcl/filters/approximate_voxel_grid.h" namespace "pcl":
    cdef cppclass ApproximateVoxelGrid[T](Filter[T]):
        ApproximateVoxelGrid()
        # ApproximateVoxelGrid (const ApproximateVoxelGrid &src) : 
        # ApproximateVoxelGrid& operator = (const ApproximateVoxelGrid &src)
        # ApproximateVoxelGrid& element "operator()"(ApproximateVoxelGrid src)
        # using Filter<PointT>::filter_name_;
        # using Filter<PointT>::getClassName;
        # using Filter<PointT>::input_;
        # using Filter<PointT>::indices_;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # public:
        # * \brief Set the voxel grid leaf size.
        # * \param[in] leaf_size the voxel grid leaf size
        void setLeafSize (eigen3.Vector3f &leaf_size) 
        # * \brief Set the voxel grid leaf size.
        # * \param[in] lx the leaf size for X
        # * \param[in] ly the leaf size for Y
        # * \param[in] lz the leaf size for Z
        void setLeafSize (float lx, float ly, float lz)
        # /** \brief Get the voxel grid leaf size. */
        eigen3.Vector3f getLeafSize ()
        # * \brief Set to true if all fields need to be downsampled, or false if just XYZ.
        # * \param downsample the new value (true/false)
        void setDownsampleAllData (bool downsample)
        # * \brief Get the state of the internal downsampling parameter (true if
        # * all fields need to be downsampled, false if just XYZ). 
        bool getDownsampleAllData () const
###

# bilateral.h
# template<typename PointT>
# class BilateralFilter : public Filter<PointT>
cdef extern from "pcl/filters/bilateral.h" namespace "pcl":
    cdef cppclass BilateralFilter[T](Filter[T]):
        BilateralFilter()
        # using Filter<PointT>::input_;
        # using Filter<PointT>::indices_;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename pcl::search::Search<PointT>::Ptr KdTreePtr;
        # public:
        # * \brief Filter the input data and store the results into output
        # * \param[out] output the resultant point cloud message
        void applyFilter (cpp.PointCloud[T] &output)
        # * \brief Compute the intensity average for a single point
        # * \param[in] pid the point index to compute the weight for
        # * \param[in] indices the set of nearest neighor indices 
        # * \param[in] distances the set of nearest neighbor distances
        # * \return the intensity average at a given point index
        double  computePointWeight (const int pid, const vector[int] &indices, const vector[float] &distances)
        # * \brief Set the half size of the Gaussian bilateral filter window.
        # * \param[in] sigma_s the half size of the Gaussian bilateral filter window to use
        void setHalfSize (const double sigma_s)
        # * \brief Get the half size of the Gaussian bilateral filter window as set by the user. */
        double getHalfSize ()
        # \brief Set the standard deviation parameter
        # * \param[in] sigma_r the new standard deviation parameter
        void setStdDev (const double sigma_r)
        # * \brief Get the value of the current standard deviation parameter of the bilateral filter. */
        double getStdDev ()
        # * \brief Provide a pointer to the search object.
        # * \param[in] tree a pointer to the spatial search object.
        # void setSearchMethod (const KdTreePtr &tree)
###

# clipper3D.h
# Override class
# template<typename PointT>
# class Clipper3D
#     public:
#         * \brief virtual destructor. Never throws an exception.
#       virtual ~Clipper3D () throw () {}
# 
#         * \brief interface to clip a single point
#         * \param[in] point the point to check against
#         * \return true, it point still exists, false if its clipped
#       virtual bool clipPoint3D (const PointT& point) const = 0;
# 
#         * \brief interface to clip a line segment given by two end points. The order of the end points is unimportant and will sty the same after clipping.
#         * This means basically, that the direction of the line will not flip after clipping.
#         * \param[in,out] pt1 start point of the line
#         * \param[in,out] pt2 end point of the line
#         * \return true if the clipped line is not empty, thus the parameters are still valid, false if line completely outside clipping space
#       virtual bool clipLineSegment3D (PointT& pt1, PointT& pt2) const = 0;
# 
#         * \brief interface to clip a planar polygon given by an ordered list of points
#         * \param[in,out] polygon the polygon in any direction (ccw or cw) but ordered, thus two neighboring points define an edge of the polygon
#       virtual void clipPlanarPolygon3D (std::vector<PointT>& polygon) const = 0;
# 
#         * \brief interface to clip a planar polygon given by an ordered list of points
#         * \param[in] polygon the polygon in any direction (ccw or cw) but ordered, thus two neighboring points define an edge of the polygon
#         * \param[out] clipped_polygon the clipped polygon
#       virtual void clipPlanarPolygon3D (const std::vector<PointT>& polygon, std::vector<PointT>& clipped_polygon) const = 0;
# 
#         * \brief interface to clip a point cloud
#         * \param[in] cloud_in input point cloud
#         * \param[out] clipped indices of points that remain after clipping the input cloud
#         * \param[in] indices the indices of points in the point cloud to be clipped.
#         * \return list of indices of remaining points after clipping.
#       virtual void clipPointCloud3D (const pcl::PointCloud<PointT> &cloud_in, std::vector<int>& clipped, const std::vector<int>& indices = std::vector<int> ()) const = 0;
# 
#         * \brief polymorphic method to clone the underlying clipper with its parameters.
#         * \return the new clipper object from the specific subclass with all its parameters.
#       virtual Clipper3D<PointT>* clone () const = 0;
###

# conditional_removal.h
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl::ComparisonOps":
# typedef enum 
# {
# GT, GE, LT, LE, EQ
# }
# CompareOp;

# NG ###
# no define constructor
# 
# template<typename PointT>
# class PointDataAtOffset
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
#     cdef cppclass PointDataAtOffset[T]:
#         # PointDataAtOffset (uint8_t datatype, uint32_t offset)
#         # int compare (const T& p, const double& val);
###
# template<typename PointT>
# class FieldComparison : public ComparisonBase<PointT>
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
#     cdef cppclass FieldComparison[T](ComparisonBase[T]):
#       FieldComparison (string field_name, CompareOp op, double compare_val)
#         # FieldComparison (string field_name, CompareOp op, double compare_val)
#         # FieldComparison (const FieldComparison &src) :
#         # FieldComparison& operator = (const FieldComparison &src)
#         # using ComparisonBase<PointT>::field_name_;
#         # using ComparisonBase<PointT>::op_;
#         # using ComparisonBase<PointT>::capable_;
#         # public:
#         #   typedef boost::shared_ptr<FieldComparison<PointT> > Ptr;
#         #   typedef boost::shared_ptr<const FieldComparison<PointT> > ConstPtr;
###

# template<typename PointT>
# class PackedRGBComparison : public ComparisonBase<PointT>
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
#     cdef cppclass PackedRGBComparison[T](ComparisonBase[T]):
#         # PackedRGBComparison (string component_name, CompareOp op, double compare_val)
#         # using ComparisonBase<PointT>::capable_;
#         # using ComparisonBase<PointT>::op_;
#         # virtual boolevaluate (const PointT &point) const;
# 
# # template<typename PointT>
# # class PackedHSIComparison : public ComparisonBase<PointT>
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
#     cdef cppclass PackedHSIComparison[T](ComparisonBase[T]):
#         # PackedHSIComparison (string component_name, CompareOp op, double compare_val)
#         # using ComparisonBase<PointT>::capable_;
#         # using ComparisonBase<PointT>::op_;
#         # public:
#         # * \brief Construct a PackedHSIComparison 
#         # * \param component_name either "h", "s" or "i"
#         # * \param op the operator to use when making the comparison
#         # * \param compare_val the constant value to compare the component value too
#         # typedef enum
#         # {
#         #   H, // -128 to 127 corresponds to -pi to pi
#         #   S, // 0 to 255
#         #   I  // 0 to 255
#         # } ComponentId;
# 
# # template<typename PointT>
# # class TfQuadraticXYZComparison : public pcl::ComparisonBase<PointT>
# cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
#     cdef cppclass TfQuadraticXYZComparison[T](ComparisonBase[T]):
#         TfQuadraticXYZComparison ()
#         # * \param op the operator "[OP]" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # * \param comparison_matrix the matrix "A" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # * \param comparison_vector the vector "v" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # * \param comparison_scalar the scalar "c" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # * \param comparison_transform the transformation of the comparison.
#         # TfQuadraticXYZComparison (const pcl::ComparisonOps::CompareOp op, const Eigen::Matrix3f &comparison_matrix,
#         #                         const Eigen::Vector3f &comparison_vector, const float &comparison_scalar,
#         #                         const Eigen::Affine3f &comparison_transform = Eigen::Affine3f::Identity ());
#         # public:
#         # EIGEN_MAKE_ALIGNED_OPERATOR_NEW     //needed whenever there is a fixed size Eigen:: vector or matrix in a class
#         # ctypedef boost::shared_ptr<TfQuadraticXYZComparison<PointT> > Ptr;
#         # typedef boost::shared_ptr<const TfQuadraticXYZComparison<PointT> > ConstPtr;
#         # void setComparisonOperator (const pcl::ComparisonOps::CompareOp op)
#         # * \brief set the matrix "A" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         #  */
#         # void setComparisonMatrix (const Eigen::Matrix3f &matrix)
#         # * \brief set the matrix "A" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # void setComparisonMatrix (const Eigen::Matrix4f &homogeneousMatrix)
#         # * \brief set the vector "v" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # void setComparisonVector (const Eigen::Vector3f &vector)
#         # * \brief set the vector "v" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # void setComparisonVector (const Eigen::Vector4f &homogeneousVector)
#         # * \brief set the scalar "c" of the comparison "p'Ap + 2v'p + c [OP] 0".
#         # void setComparisonScalar (const float &scalar)
#         # * \brief transform the coordinate system of the comparison. If you think of
#         # * the transformation to be a translation and rotation of the comparison in the
#         # * same coordinate system, you have to provide the inverse transformation.
#         # * This function does not change the original definition of the comparison. Thus,
#         # * each call of this function will assume the original definition of the comparison
#         # * as starting point for the transformation.
#         # * @param transform the transformation (rotation and translation) as an affine matrix.
#         # void transformComparison (const Eigen::Matrix4f &transform)
#         # * \brief transform the coordinate system of the comparison. If you think of
#         # * the transformation to be a translation and rotation of the comparison in the
#         # * same coordinate system, you have to provide the inverse transformation.
#         # * This function does not change the original definition of the comparison. Thus,
#         # * each call of this function will assume the original definition of the comparison
#         # * as starting point for the transformation.
#         # * @param transform the transformation (rotation and translation) as an affine matrix.
#         # void transformComparison (const Eigen::Affine3f &transform)
#         # \brief Determine the result of this comparison.
#         # \param point the point to evaluate
#         # \return the result of this comparison.
#         # virtual bool evaluate (const PointT &point) const;
# ###
# NG end ###

# template<typename PointT>
# class ConditionAnd : public ConditionBase<PointT>
cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
    cdef cppclass ConditionAnd[T](ConditionBase[T]):
        ConditionAnd()
        # using ConditionBase<PointT>::conditions_;
        # using ConditionBase<PointT>::comparisons_;
        # public:
        # ctypedef boost::shared_ptr<ConditionAnd<PointT> > Ptr;
        # ctypedef boost::shared_ptr<const ConditionAnd<PointT> > ConstPtr;
###

# template<typename PointT>
# class ConditionOr : public ConditionBase<PointT>
cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
    cdef cppclass ConditionOr[T](ConditionBase[T]):
        ConditionOr()
        # using ConditionBase<PointT>::conditions_;
        # using ConditionBase<PointT>::comparisons_;
        # public:
        # ctypedef boost::shared_ptr<ConditionOr<PointT> > Ptr;
        # ctypedef boost::shared_ptr<const ConditionOr<PointT> > ConstPtr;
###

# template<typename PointT>
# class ConditionalRemoval : public Filter<PointT>
cdef extern from "pcl/filters/conditional_removal.h" namespace "pcl":
    cdef cppclass ConditionalRemoval[T](Filter[T]):
        ConditionalRemoval()
        # ConditionalRemoval(int)
        # ConditionalRemoval (ConditionBasePtr condition, bool extract_removed_indices = false) :
        # using Filter<PointT>::input_;
        # using Filter<PointT>::filter_name_;
        # using Filter<PointT>::getClassName;
        # using Filter<PointT>::removed_indices_;
        # using Filter<PointT>::extract_removed_indices_;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # public:
        # ctypedef typename pcl::ConditionBase<PointT> ConditionBase;
        # ctypedef typename ConditionBase::Ptr ConditionBasePtr;
        # ctypedef typename ConditionBase::ConstPtr ConditionBaseConstPtr;
        void setKeepOrganized (bool val)
        bool getKeepOrganized ()
        void setUserFilterValue (float val)
        # void setCondition (ConditionBasePtr condition);
###

# crop_box.h
# template<typename PointT>
# class CropBox : public FilterIndices<PointT>
cdef extern from "pcl/filters/crop_box.h" namespace "pcl":
    cdef cppclass CropBox[T](FilterIndices[T]):
        CropBox()
        # using Filter<PointT>::filter_name_;
        # using Filter<PointT>::getClassName;
        # using Filter<PointT>::indices_;
        # using Filter<PointT>::input_;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # public:
        # * \brief Set the minimum point of the box
        # * \param[in] min_pt the minimum point of the box
        # void setMin (const eigen3.Vector4f &min_pt)
        # """
        #     brief Get the value of the minimum point of the box, as set by the user
        #     return the value of the internal \a min_pt parameter.
        # """
        # eigen3.Vector4f getMin () const
        # * \brief Set the maximum point of the box
        # * \param[in] max_pt the maximum point of the box
        # void setMax (const eigen3.Vector4f &max_pt)
        # \brief Get the value of the maxiomum point of the box, as set by the user
        # \return the value of the internal \a max_pt parameter.
        # eigen3.Vector4f getMax () const
        # \brief Set a translation value for the box
        # \param[in] translation the (tx,ty,tz) values that the box should be translated by
        # void setTranslation (const Eigen::Vector3f &translation)
        # \brief Get the value of the box translation parameter as set by the user. */
        # Eigen::Vector3f getTranslation () const
        # \brief Set a rotation value for the box
        # \param[in] rotation the (rx,ry,rz) values that the box should be rotated by
        # void setRotation (const Eigen::Vector3f &rotation)
        # \brief Get the value of the box rotatation parameter, as set by the user. */
        # Eigen::Vector3f getRotation () const
        # \brief Set a transformation that should be applied to the cloud before filtering
        # \param[in] transform an affine transformation that needs to be applied to the cloud before filtering
        # void setTransform (const Eigen::Affine3f &transform)
        # \brief Get the value of the transformation parameter, as set by the user. */
        # Eigen::Affine3f getTransform () const

#  template<>
#  class PCL_EXPORTS CropBox<sensor_msgs::PointCloud2> : public FilterIndices<sensor_msgs::PointCloud2>
#    using Filter<sensor_msgs::PointCloud2>::filter_name_;
#    using Filter<sensor_msgs::PointCloud2>::getClassName;
#    typedef sensor_msgs::PointCloud2 PointCloud2;
#    typedef PointCloud2::Ptr PointCloud2Ptr;
#    typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#    public:
#    /** \brief Empty constructor. */
#      CropBox () :
#      /** \brief Set the minimum point of the box
#        * \param[in] min_pt the minimum point of the box
#        */
#      void setMin (const Eigen::Vector4f& min_pt)
#      /** \brief Get the value of the minimum point of the box, as set by the user
#        * \return the value of the internal \a min_pt parameter.
#        */
#      Eigen::Vector4f getMin () const
#      /** \brief Set the maximum point of the box
#        * \param[in] max_pt the maximum point of the box
#        */
#      void setMax (const Eigen::Vector4f &max_pt)
#      /** \brief Get the value of the maxiomum point of the box, as set by the user
#        * \return the value of the internal \a max_pt parameter.
#        */
#      Eigen::Vector4f getMax () const
#      /** \brief Set a translation value for the box
#        * \param[in] translation the (tx,ty,tz) values that the box should be translated by
#        */
#      void setTranslation (const Eigen::Vector3f &translation)
#      /** \brief Get the value of the box translation parameter as set by the user. */
#      Eigen::Vector3f getTranslation () const
#      /** \brief Set a rotation value for the box
#        * \param[in] rotation the (rx,ry,rz) values that the box should be rotated by
#        */
#      void setRotation (const Eigen::Vector3f &rotation)
#      /** \brief Get the value of the box rotatation parameter, as set by the user. */
#      Eigen::Vector3f getRotation () const
#      /** \brief Set a transformation that should be applied to the cloud before filtering
#        * \param[in] transform an affine transformation that needs to be applied to the cloud before filtering
#        */
#      void setTransform (const Eigen::Affine3f &transform)
#      /** \brief Get the value of the transformation parameter, as set by the user. */
#      Eigen::Affine3f getTransform () const
###

# crop_hull.h
#  template<typename PointT>
#  class CropHull: public FilterIndices<PointT>
cdef extern from "pcl/filters/crop_hull.h" namespace "pcl":
    cdef cppclass CropHull[T](FilterIndices[T]):
        CropHull()
        # using Filter<PointT>::filter_name_;
        # using Filter<PointT>::indices_;
        # using Filter<PointT>::input_;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # brief Set the vertices of the hull used to filter points.
        # param[in] polygons Vector of polygons (Vertices structures) forming
        # the hull used for filtering points.
        void setHullIndices (const vector[cpp.Vertices]& polygons)
        # brief Get the vertices of the hull used to filter points.
        vector[cpp.Vertices] getHullIndices () const
        # \brief Set the point cloud that the hull indices refer to
        # \param[in] points the point cloud that the hull indices refer to
        void setHullCloud (cpp.PointCloudPtr_t points)
        #/\brief Get the point cloud that the hull indices refer to. */
        cpp.PointCloudPtr_t getHullCloud () const
        # brief Set the dimensionality of the hull to be used.
        # This should be set to correspond to the dimensionality of the
        # convex/concave hull produced by the pcl::ConvexHull and
        # pcl::ConcaveHull classes.
        # param[in] dim Dimensionailty of the hull used to filter points.
        void setDim (int dim)
        # \brief Remove points outside the hull (default), or those inside the hull.
        # \param[in] crop_outside If true, the filter will remove points
        # outside the hull. If false, those inside will be removed.
        void setCropOutside(bool crop_outside)
###

# extract_indices.h
# template<typename PointT>
# class ExtractIndices : public FilterIndices<PointT>
cdef extern from "pcl/filters/extract_indices.h" namespace "pcl":
    cdef cppclass ExtractIndices[T](FilterIndices[T]):
        ExtractIndices()
        # ctypedef typename FilterIndices<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # ctypedef typename pcl::traits::fieldList<PointT>::type FieldList;
        # * \brief Apply the filter and store the results directly in the input cloud.
        # * \details This method will save the time and memory copy of an output cloud but can not alter the original size of the input cloud:
        # * It operates as though setKeepOrganized() is true and will overwrite the filtered points instead of remove them.
        # * All fields of filtered points are replaced with the value set by setUserFilterValue() (default = NaN).
        # * This method also automatically alters the input cloud set via setInputCloud().
        # * It does not alter the value of the internal keep organized boolean as set by setKeepOrganized().
        # * \param[in/out] cloud The point cloud used for input and output.
        void filterDirectly (cpp.PointCloudPtr_t &cloud);

# template<>
# class PCL_EXPORTS ExtractIndices<sensor_msgs::PointCloud2> : public FilterIndices<sensor_msgs::PointCloud2>
# public:
#       typedef sensor_msgs::PointCloud2 PointCloud2;
#       typedef PointCloud2::Ptr PointCloud2Ptr;
#       typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#       /** \brief Empty constructor. */
#       ExtractIndices ()
#     protected:
#       using PCLBase<PointCloud2>::input_;
#       using PCLBase<PointCloud2>::indices_;
#       using PCLBase<PointCloud2>::use_indices_;
#       using Filter<PointCloud2>::filter_name_;
#       using Filter<PointCloud2>::getClassName;
#       using FilterIndices<PointCloud2>::negative_;
#       using FilterIndices<PointCloud2>::keep_organized_;
#       using FilterIndices<PointCloud2>::user_filter_value_;
#       /** \brief Extract point indices into a separate PointCloud
#         * \param[out] output the resultant point cloud
#       void applyFilter (PointCloud2 &output);
#       /** \brief Extract point indices
#         * \param indices the resultant indices
#       void applyFilter (std::vector<int> &indices);
###

# normal_space.h
# template<typename PointT, typename NormalT>
# class NormalSpaceSampling : public FilterIndices<PointT>
cdef extern from "pcl/filters/normal_space.h" namespace "pcl":
    cdef cppclass NormalSpaceSampling[T, Normal](FilterIndices[T]):
        NormalSpaceSampling()
        # using FilterIndices<PointT>::filter_name_;
        # using FilterIndices<PointT>::getClassName;
        # using FilterIndices<PointT>::indices_;
        # using FilterIndices<PointT>::input_;
        # ctypedef typename FilterIndices<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # ctypedef typename pcl::PointCloud<NormalT>::Ptr NormalsPtr;
        # /** \brief Set number of indices to be sampled.
        #   * \param[in] sample the number of sample indices
        void setSample (unsigned int sample)
        # /** \brief Get the value of the internal \a sample parameter. */
        unsigned int getSample () const
        #  \brief Set seed of random function.
        #   * \param[in] seed the input seed
        void setSeed (unsigned int seed)
        # /** \brief Get the value of the internal \a seed parameter. */
        unsigned int getSeed () const
        # /** \brief Set the number of bins in x, y and z direction
        #   * \param[in] binsx number of bins in x direction
        #   * \param[in] binsy number of bins in y direction
        #   * \param[in] binsz number of bins in z direction
        void setBins (unsigned int binsx, unsigned int binsy, unsigned int binsz)
        # /** \brief Get the number of bins in x, y and z direction
        #   * \param[out] binsx number of bins in x direction
        #   * \param[out] binsy number of bins in y direction
        #   * \param[out] binsz number of bins in z direction
        void getBins (unsigned int& binsx, unsigned int& binsy, unsigned int& binsz) const
        # * \brief Set the normals computed on the input point cloud
        #   * \param[in] normals the normals computed for the input cloud
        # void setNormals (const NormalsPtr &normals)
        # * \brief Get the normals computed on the input point cloud */
        # NormalsPtr getNormals () const
###

# passthrough.h
# template <typename PointT>
# class PassThrough : public FilterIndices<PointT>
#   cdef cppclass PassThrough[T](FilterIndices[T]):
cdef extern from "pcl/filters/passthrough.h" namespace "pcl":
    cdef cppclass PassThrough[T]:
        PassThrough()
        void setFilterFieldName (string field_name)
        void setFilterLimits (float min, float max)
        void setInputCloud (shared_ptr[cpp.PointCloud[T]])
        void filter(cpp.PointCloud[T] c)

ctypedef PassThrough[cpp.PointXYZ] PassThrough_t
ctypedef PassThrough[cpp.PointXYZRGBA] PassThrough2_t

# template<>
# class PCL_EXPORTS PassThrough<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#     typedef sensor_msgs::PointCloud2 PointCloud2;
#     typedef PointCloud2::Ptr PointCloud2Ptr;
#     typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#     using Filter<sensor_msgs::PointCloud2>::removed_indices_;
#     using Filter<sensor_msgs::PointCloud2>::extract_removed_indices_;
#     public:
#       /** \brief Constructor. */
#       PassThrough (bool extract_removed_indices = false) :
#       /** \brief Set whether the filtered points should be kept and set to the
#         * value given through \a setUserFilterValue (default: NaN), or removed
#         * from the PointCloud, thus potentially breaking its organized
#         * structure. By default, points are removed.
#         * \param[in] val set to true whether the filtered points should be kept and
#         * set to a given user value (default: NaN)
#       void setKeepOrganized (bool val)
#       /** \brief Obtain the value of the internal \a keep_organized_ parameter. */
#       bool getKeepOrganized ()
#       /** \brief Provide a value that the filtered points should be set to
#         * instead of removing them.  Used in conjunction with \a
#         * setKeepOrganized ().
#         * \param[in] val the user given value that the filtered point dimensions should be set to
#       void setUserFilterValue (float val)
#       /** \brief Provide the name of the field to be used for filtering data. In conjunction with  \a setFilterLimits,
#         * points having values outside this interval will be discarded.
#         * \param[in] field_name the name of the field that contains values used for filtering
#       void setFilterFieldName (const string &field_name)
#       /** \brief Get the name of the field used for filtering. */
#       string const getFilterFieldName ()
#       /** \brief Set the field filter limits. All points having field values outside this interval will be discarded.
#         * \param[in] limit_min the minimum allowed field value
#         * \param[in] limit_max the maximum allowed field value
#       void setFilterLimits (const double &limit_min, const double &limit_max)
#       /** \brief Get the field filter limits (min/max) set by the user. The default values are -FLT_MAX, FLT_MAX. 
#         * \param[out] limit_min the minimum allowed field value
#         * \param[out] limit_max the maximum allowed field value
#       void getFilterLimits (double &limit_min, double &limit_max)
#       /** \brief Set to true if we want to return the data outside the interval specified by setFilterLimits (min, max).
#         * Default: false.
#         * \param[in] limit_negative return data inside the interval (false) or outside (true)
#       void setFilterLimitsNegative (const bool limit_negative)
#       /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
#         * \param[out] limit_negative true if data \b outside the interval [min; max] is to be returned, false otherwise
#       void getFilterLimitsNegative (bool &limit_negative)
#       /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
#         * \return true if data \b outside the interval [min; max] is to be returned, false otherwise
#       bool getFilterLimitsNegative ()
###

# plane_clipper3D.h
# template<typename PointT>
# class PlaneClipper3D : public Clipper3D<PointT>
# cdef extern from "pcl/filters/plane_clipper3D.h" namespace "pcl":
#     cdef cppclass PlaneClipper3D[T](Clipper3D[T]):
#         # PlaneClipper3D (const Eigen::Vector4f& plane_params);
#         #   * \brief Set new plane parameters
#         #   * \param plane_params
#         # void setPlaneParameters (const Eigen::Vector4f& plane_params);
#         #   * \brief return the current plane parameters
#         #   * \return the current plane parameters
#         # const Eigen::Vector4f& getPlaneParameters () const;
#         # virtual bool clipPoint3D (const PointT& point) const;
#         # virtual bool clipLineSegment3D (PointT& from, PointT& to) const;
#         # virtual void clipPlanarPolygon3D (const std::vector<PointT>& polygon, std::vector<PointT>& clipped_polygon) const;
#         # virtual void
#         # clipPointCloud3D (const pcl::PointCloud<PointT> &cloud_in, std::vector<int>& clipped, const std::vector<int>& indices = std::vector<int> ()) const;
#         # virtual Clipper3D<PointT>*
#         # clone () const;
###

# project_inliers.h
# template<typename PointT>
# class ProjectInliers : public Filter<PointT>
cdef extern from "pcl/filters/project_inliers.h" namespace "pcl":
    cdef cppclass ProjectInliers[T](Filter[T]):
        ProjectInliers ()
        # using Filter<PointT>::input_;
        # using Filter<PointT>::indices_;
        # using Filter<PointT>::filter_name_;
        # using Filter<PointT>::getClassName;
        # ctypedef typename Filter<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # ctypedef typename SampleConsensusModel<PointT>::Ptr SampleConsensusModelPtr;
        # public:
        # \brief The type of model to use (user given parameter).
        # \param model the model type (check \a model_types.h)
        void setModelType (int model)
        # \brief Get the type of SAC model used. */
        int getModelType ()
        # \brief Provide a pointer to the model coefficients.
        # \param model a pointer to the model coefficients
        # void setModelCoefficients (const ModelCoefficientsConstPtr &model)
        # \brief Get a pointer to the model coefficients. */
        # ModelCoefficientsConstPtr getModelCoefficients ()
        # \brief Set whether all data will be returned, or only the projected inliers.
        # \param val true if all data should be returned, false if only the projected inliers
        void setCopyAllData (bool val)
        # \brief Get whether all data is being copied (true), or only the projected inliers (false). */
        bool getCopyAllData ()
###

# template<>
# class PCL_EXPORTS ProjectInliers<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#     using Filter<sensor_msgs::PointCloud2>::filter_name_;
#     using Filter<sensor_msgs::PointCloud2>::getClassName;
#     typedef sensor_msgs::PointCloud2 PointCloud2;
#     typedef PointCloud2::Ptr PointCloud2Ptr;
#     typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#     typedef SampleConsensusModel<PointXYZ>::Ptr SampleConsensusModelPtr;
#     public:
#       /** \brief Empty constructor. */
#       ProjectInliers () : model_type_ (), copy_all_data_ (false), copy_all_fields_ (true), model_ (), sacmodel_ ()
#       /** \brief The type of model to use (user given parameter).
#         * \param[in] model the model type (check \a model_types.h)
#       void setModelType (int model)
#       /** \brief Get the type of SAC model used. */
#       int getModelType () const
#       /** \brief Provide a pointer to the model coefficients.
#         * \param[in] model a pointer to the model coefficients
#       void setModelCoefficients (const ModelCoefficientsConstPtr &model)
#       /** \brief Get a pointer to the model coefficients. */
#       ModelCoefficientsConstPtr getModelCoefficients () const
#       /** \brief Set whether all fields should be copied, or only the XYZ.
#         * \param[in] val true if all fields will be returned, false if only XYZ
#       void setCopyAllFields (bool val)
#       /** \brief Get whether all fields are being copied (true), or only XYZ (false). */
#       bool getCopyAllFields () const
#       /** \brief Set whether all data will be returned, or only the projected inliers.
#         * \param[in] val true if all data should be returned, false if only the projected inliers
#       void setCopyAllData (bool val)
#       /** \brief Get whether all data is being copied (true), or only the projected inliers (false). */
#       bool getCopyAllData () const
###

# radius_outlier_removal.h
# template<typename PointT>
# class RadiusOutlierRemoval : public FilterIndices<PointT>
cdef extern from "pcl/filters/radius_outlier_removal.h" namespace "pcl":
    cdef cppclass RadiusOutlierRemoval[T](FilterIndices[T]):
        RadiusOutlierRemoval ()
        # protected:
        # ctypedef typename FilterIndices<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # ctypedef typename pcl::search::Search<PointT>::Ptr SearcherPtr;
        # * \brief Set the radius of the sphere that will determine which points are neighbors.
        # * \details The number of points within this distance from the query point will need to be equal or greater
        # * than setMinNeighborsInRadius() in order to be classified as an inlier point (i.e. will not be filtered).
        # * \param[in] radius The radius of the sphere for nearest neighbor searching.
        void setRadiusSearch (double radius)
        # * \brief Get the radius of the sphere that will determine which points are neighbors.
        # * \details The number of points within this distance from the query point will need to be equal or greater
        # * than setMinNeighborsInRadius() in order to be classified as an inlier point (i.e. will not be filtered).
        # * \return The radius of the sphere for nearest neighbor searching.
        double getRadiusSearch ()
        # * \brief Set the number of neighbors that need to be present in order to be classified as an inlier.
        # * \details The number of points within setRadiusSearch() from the query point will need to be equal or greater
        # * than this number in order to be classified as an inlier point (i.e. will not be filtered).
        # * \param min_pts The minimum number of neighbors (default = 1).
        void setMinNeighborsInRadius (int min_pts)
        # * \brief Get the number of neighbors that need to be present in order to be classified as an inlier.
        # * \details The number of points within setRadiusSearch() from the query point will need to be equal or greater
        # * than this number in order to be classified as an inlier point (i.e. will not be filtered).
        # * \param min_pts The minimum number of neighbors (default = 1).
        int getMinNeighborsInRadius ()

# template<>
# class PCL_EXPORTS RadiusOutlierRemoval<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#       using Filter<sensor_msgs::PointCloud2>::filter_name_;
#       using Filter<sensor_msgs::PointCloud2>::getClassName;
#       using Filter<sensor_msgs::PointCloud2>::removed_indices_;
#       using Filter<sensor_msgs::PointCloud2>::extract_removed_indices_;
#       typedef pcl::search::Search<pcl::PointXYZ> KdTree;
#       typedef pcl::search::Search<pcl::PointXYZ>::Ptr KdTreePtr;
#       typedef sensor_msgs::PointCloud2 PointCloud2;
#       typedef PointCloud2::Ptr PointCloud2Ptr;
#       typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#       public:
#       /** \brief Empty constructor. */
#       RadiusOutlierRemoval (bool extract_removed_indices = false) :
#       /** \brief Set the sphere radius that is to be used for determining the k-nearest neighbors for filtering.
#       * \param radius the sphere radius that is to contain all k-nearest neighbors
#       */
#       void setRadiusSearch (double radius)
#       /** \brief Get the sphere radius used for determining the k-nearest neighbors. */
#       double getRadiusSearch ()
#       /** \brief Set the minimum number of neighbors that a point needs to have in the given search radius in order to
#       * be considered an inlier (i.e., valid).
#       * \param min_pts the minimum number of neighbors
#       */
#       void setMinNeighborsInRadius (int min_pts)
#       /** \brief Get the minimum number of neighbors that a point needs to have in the given search radius to be
#       * considered an inlier and avoid being filtered. 
#       */
#       double getMinNeighborsInRadius ()
###

# random_sample.h
# template<typename PointT>
# class RandomSample : public FilterIndices<PointT>
# cdef cppclass RandomSample[T](FilterIndices[T]):
cdef extern from "pcl/filters/random_sample.h" namespace "pcl":
    cdef cppclass RandomSample[T](FilterIndices[T]):
        RandomSample ()
        # using FilterIndices<PointT>::filter_name_;
        # using FilterIndices<PointT>::getClassName;
        # using FilterIndices<PointT>::indices_;
        # using FilterIndices<PointT>::input_;
        # ctypedef typename FilterIndices<PointT>::PointCloud PointCloud;
        # ctypedef typename PointCloud::Ptr PointCloudPtr;
        # ctypedef typename PointCloud::ConstPtr PointCloudConstPtr;
        # public:
        # /** \brief Set number of indices to be sampled.
        #   * \param sample
        void setSample (unsigned int sample)
        # /** \brief Get the value of the internal \a sample parameter.
        unsigned int getSample ()
        # /** \brief Set seed of random function.
        #   * \param seed
        void setSeed (unsigned int seed)
        # /** \brief Get the value of the internal \a seed parameter.
        unsigned int getSeed ()

# template<>
# class PCL_EXPORTS RandomSample<sensor_msgs::PointCloud2> : public FilterIndices<sensor_msgs::PointCloud2>
#     using FilterIndices<sensor_msgs::PointCloud2>::filter_name_;
#     using FilterIndices<sensor_msgs::PointCloud2>::getClassName;
#     typedef sensor_msgs::PointCloud2 PointCloud2;
#     typedef PointCloud2::Ptr PointCloud2Ptr;
#     typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#     public:
#       /** \brief Empty constructor. */
#       RandomSample () : sample_ (UINT_MAX), seed_ (static_cast<unsigned int> (time (NULL)))
#       /** \brief Set number of indices to be sampled.
#         * \param sample
#       void setSample (unsigned int sample)
#       /** \brief Get the value of the internal \a sample parameter.
#       unsigned int getSample ()
#       /** \brief Set seed of random function.
#         * \param seed
#       void setSeed (unsigned int seed)
#       /** \brief Get the value of the internal \a seed parameter.
#       unsigned int getSeed ()
###

# statistical_outlier_removal.h
# template<typename PointT>
# class StatisticalOutlierRemoval : public FilterIndices<PointT>
# NG
# cdef cppclass StatisticalOutlierRemoval[T](FilterIndices[T]):
cdef extern from "pcl/filters/statistical_outlier_removal.h" namespace "pcl":
    cdef cppclass StatisticalOutlierRemoval[T]:
        StatisticalOutlierRemoval()
        int getMeanK()
        void setMeanK (int nr_k)
        double getStddevMulThresh()
        void setStddevMulThresh (double std_mul)
        bool getNegative()
        void setNegative (bool negative)
        void setInputCloud (shared_ptr[cpp.PointCloud[T]])
        void filter(cpp.PointCloud[T] &c)

ctypedef StatisticalOutlierRemoval[cpp.PointXYZ] StatisticalOutlierRemoval_t
ctypedef StatisticalOutlierRemoval[cpp.PointXYZRGBA] StatisticalOutlierRemoval2_t

# template<>
# class PCL_EXPORTS StatisticalOutlierRemoval<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#     using Filter<sensor_msgs::PointCloud2>::filter_name_;
#     using Filter<sensor_msgs::PointCloud2>::getClassName;
#     using Filter<sensor_msgs::PointCloud2>::removed_indices_;
#     using Filter<sensor_msgs::PointCloud2>::extract_removed_indices_;
#     typedef pcl::search::Search<pcl::PointXYZ> KdTree;
#     typedef pcl::search::Search<pcl::PointXYZ>::Ptr KdTreePtr;
#     typedef sensor_msgs::PointCloud2 PointCloud2;
#     typedef PointCloud2::Ptr PointCloud2Ptr;
#     typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#     public:
#       /** \brief Empty constructor. */
#       StatisticalOutlierRemoval (bool extract_removed_indices = false) :
#       /** \brief Set the number of points (k) to use for mean distance estimation
#         * \param nr_k the number of points to use for mean distance estimation
#       void setMeanK (int nr_k)
#       /** \brief Get the number of points to use for mean distance estimation. */
#       int getMeanK ()
#       /** \brief Set the standard deviation multiplier threshold. All points outside the
#         * \f[ \mu \pm \sigma \cdot std\_mul \f]
#         * will be considered outliers, where \f$ \mu \f$ is the estimated mean,
#         * and \f$ \sigma \f$ is the standard deviation.
#         * \param std_mul the standard deviation multiplier threshold
#       void setStddevMulThresh (double std_mul)
#       /** \brief Get the standard deviation multiplier threshold as set by the user. */
#       double getStddevMulThresh ()
#       /** \brief Set whether the indices should be returned, or all points \e except the indices.
#         * \param negative true if all points \e except the input indices will be returned, false otherwise
#       void setNegative (bool negative)
#       /** \brief Get the value of the internal #negative_ parameter. If
#         * true, all points \e except the input indices will be returned.
#         * \return The value of the "negative" flag
#       bool getNegative ()
#       void applyFilter (PointCloud2 &output);
###

# voxel_grid.h
# template <typename PointT>
# class VoxelGrid : public Filter<PointT>
#    cdef cppclass VoxelGrid[T](Filter[T]):
cdef extern from "pcl/filters/voxel_grid.h" namespace "pcl":
    cdef cppclass VoxelGrid[T]:
        VoxelGrid()
        # void setLeafSize (const Eigen::Vector4f &leaf_size) 
        void setLeafSize (float, float, float)
        void setInputCloud (shared_ptr[cpp.PointCloud[T]])
        void filter(cpp.PointCloud[T] c)
        # /** \brief Set to true if all fields need to be downsampled, or false if just XYZ.
        #   * \param[in] downsample the new value (true/false)
        #   */
        # void setDownsampleAllData (bool downsample)
        # /** \brief Get the state of the internal downsampling parameter (true if
        #   * all fields need to be downsampled, false if just XYZ). 
        #   */
        # bool getDownsampleAllData ()
        # /** \brief Set to true if leaf layout information needs to be saved for later access.
        #   * \param[in] save_leaf_layout the new value (true/false)
        #   */
        # void setSaveLeafLayout (bool save_leaf_layout)
        # /** \brief Returns true if leaf layout information will to be saved for later access. */
        # bool 
        # getSaveLeafLayout () { return (save_leaf_layout_); }
        # /** \brief Get the minimum coordinates of the bounding box (after
        #   * filtering is performed). 
        #   */
        # Eigen::Vector3i 
        # getMinBoxCoordinates () { return (min_b_.head<3> ()); }
        # /** \brief Get the minimum coordinates of the bounding box (after
        #   * filtering is performed). 
        #   */
        # Eigen::Vector3i 
        # getMaxBoxCoordinates () { return (max_b_.head<3> ()); }
        # /** \brief Get the number of divisions along all 3 axes (after filtering
        #   * is performed). 
        #   */
        # Eigen::Vector3i 
        # getNrDivisions () { return (div_b_.head<3> ()); }
        # /** \brief Get the multipliers to be applied to the grid coordinates in
        #   * order to find the centroid index (after filtering is performed). 
        #   */
        # Eigen::Vector3i getDivisionMultiplier () { return (divb_mul_.head<3> ()); }
        # /** \brief Returns the index in the resulting downsampled cloud of the specified point.
        #   *
        #   * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering 
        #   * performed, and that the point is inside the grid, to avoid invalid access (or use
        #   * getGridCoordinates+getCentroidIndexAt)
        #   *
        #   * \param[in] p the point to get the index at
        #   */
        # int getCentroidIndex (const PointT &p)
        # /** \brief Returns the indices in the resulting downsampled cloud of the points at the specified grid coordinates,
        #   * relative to the grid coordinates of the specified point (or -1 if the cell was empty/out of bounds).
        #   * \param[in] reference_point the coordinates of the reference point (corresponding cell is allowed to be empty/out of bounds)
        #   * \param[in] relative_coordinates matrix with the columns being the coordinates of the requested cells, relative to the reference point's cell
        #   * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering performed
        #   */
        # std::vector<int> getNeighborCentroidIndices (const PointT &reference_point, const Eigen::MatrixXi &relative_coordinates)
        # /** \brief Returns the layout of the leafs for fast access to cells relative to current position.
        #   * \note position at (i-min_x) + (j-min_y)*div_x + (k-min_z)*div_x*div_y holds the index of the element at coordinates (i,j,k) in the grid (-1 if empty)
        #   */
        # vector[int] getLeafLayout ()
        # /** \brief Returns the corresponding (i,j,k) coordinates in the grid of point (x,y,z). 
        #   * \param[in] x the X point coordinate to get the (i, j, k) index at
        #   * \param[in] y the Y point coordinate to get the (i, j, k) index at
        #   * \param[in] z the Z point coordinate to get the (i, j, k) index at
        #   */
        # Eigen::Vector3i getGridCoordinates (float x, float y, float z) 
        # /** \brief Returns the index in the downsampled cloud corresponding to a given set of coordinates.
        #   * \param[in] ijk the coordinates (i,j,k) in the grid (-1 if empty)
        #   */
        # int getCentroidIndexAt (const Eigen::Vector3i &ijk)
        # /** \brief Provide the name of the field to be used for filtering data. In conjunction with  \a setFilterLimits,
        #   * points having values outside this interval will be discarded.
        #   * \param[in] field_name the name of the field that contains values used for filtering
        #   */
        # void setFilterFieldName (const std::string &field_name)
        # /** \brief Get the name of the field used for filtering. */
        # std::string const getFilterFieldName ()
        # /** \brief Set the field filter limits. All points having field values outside this interval will be discarded.
        #   * \param[in] limit_min the minimum allowed field value
        #   * \param[in] limit_max the maximum allowed field value
        #   */
        # void setFilterLimits (const double &limit_min, const double &limit_max)
        # /** \brief Get the field filter limits (min/max) set by the user. The default values are -FLT_MAX, FLT_MAX. 
        #   * \param[out] limit_min the minimum allowed field value
        #   * \param[out] limit_max the maximum allowed field value
        #   */
        # void getFilterLimits (double &limit_min, double &limit_max)
        # /** \brief Set to true if we want to return the data outside the interval specified by setFilterLimits (min, max).
        #   * Default: false.
        #   * \param[in] limit_negative return data inside the interval (false) or outside (true)
        #   */
        # void setFilterLimitsNegative (const bool limit_negative)
        # /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
        #   * \param[out] limit_negative true if data \b outside the interval [min; max] is to be returned, false otherwise
        #   */
        # void getFilterLimitsNegative (bool &limit_negative)
        # /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
        #   * \return true if data \b outside the interval [min; max] is to be returned, false otherwise
        #   */
        # bool getFilterLimitsNegative ()

# template <>
# class PCL_EXPORTS VoxelGrid<sensor_msgs::PointCloud2> : public Filter<sensor_msgs::PointCloud2>
#     using Filter<sensor_msgs::PointCloud2>::filter_name_;
#     using Filter<sensor_msgs::PointCloud2>::getClassName;
#     typedef sensor_msgs::PointCloud2 PointCloud2;
#     typedef PointCloud2::Ptr PointCloud2Ptr;
#     typedef PointCloud2::ConstPtr PointCloud2ConstPtr;
#     public:
#       /** \brief Empty constructor. */
#       VoxelGrid ()
#       /** \brief Destructor. */
#       virtual ~VoxelGrid ()
#       /** \brief Set the voxel grid leaf size.
#         * \param[in] leaf_size the voxel grid leaf size
#       void setLeafSize (const Eigen::Vector4f &leaf_size) 
#       /** \brief Set the voxel grid leaf size.
#         * \param[in] lx the leaf size for X
#         * \param[in] ly the leaf size for Y
#         * \param[in] lz the leaf size for Z
#       void setLeafSize (float lx, float ly, float lz)
#       /** \brief Get the voxel grid leaf size. */
#       Eigen::Vector3f getLeafSize ()
#       /** \brief Set to true if all fields need to be downsampled, or false if just XYZ.
#         * \param[in] downsample the new value (true/false)
#       void setDownsampleAllData (bool downsample)
#       /** \brief Get the state of the internal downsampling parameter (true if
#         * all fields need to be downsampled, false if just XYZ). 
#       bool getDownsampleAllData ()
#       /** \brief Set to true if leaf layout information needs to be saved for later access.
#         * \param[in] save_leaf_layout the new value (true/false)
#       void setSaveLeafLayout (bool save_leaf_layout)
#       /** \brief Returns true if leaf layout information will to be saved for later access. */
#       bool getSaveLeafLayout ()
#       /** \brief Get the minimum coordinates of the bounding box (after
#         * filtering is performed). 
#       Eigen::Vector3i getMinBoxCoordinates ()
#       /** \brief Get the minimum coordinates of the bounding box (after
#         * filtering is performed). 
#       Eigen::Vector3i getMaxBoxCoordinates ()
#       /** \brief Get the number of divisions along all 3 axes (after filtering
#         * is performed). 
#       Eigen::Vector3i getNrDivisions ()
#       /** \brief Get the multipliers to be applied to the grid coordinates in
#         * order to find the centroid index (after filtering is performed). 
#       Eigen::Vector3i getDivisionMultiplier ()
#       /** \brief Returns the index in the resulting downsampled cloud of the specified point.
#         * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering performed,
#         * and that the point is inside the grid, to avoid invalid access (or use getGridCoordinates+getCentroidIndexAt)
#         * \param[in] x the X point coordinate to get the index at
#         * \param[in] y the Y point coordinate to get the index at
#         * \param[in] z the Z point coordinate to get the index at
#       int getCentroidIndex (float x, float y, float z)
#       /** \brief Returns the indices in the resulting downsampled cloud of the points at the specified grid coordinates,
#         * relative to the grid coordinates of the specified point (or -1 if the cell was empty/out of bounds).
#         * \param[in] x the X coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[in] y the Y coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[in] z the Z coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[out] relative_coordinates matrix with the columns being the coordinates of the requested cells, relative to the reference point's cell
#         * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering performed
#       vector[int] getNeighborCentroidIndices (float x, float y, float z, const Eigen::MatrixXi &relative_coordinates)
#       /** \brief Returns the indices in the resulting downsampled cloud of the points at the specified grid coordinates,
#         * relative to the grid coordinates of the specified point (or -1 if the cell was empty/out of bounds).
#         * \param[in] x the X coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[in] y the Y coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[in] z the Z coordinate of the reference point (corresponding cell is allowed to be empty/out of bounds)
#         * \param[out] relative_coordinates vector with the elements being the coordinates of the requested cells, relative to the reference point's cell
#         * \note for efficiency, user must make sure that the saving of the leaf layout is enabled and filtering performed
#       vector[int] getNeighborCentroidIndices (float x, float y, float z, const vector[Eigen::Vector3i] &relative_coordinates)
#       /** \brief Returns the layout of the leafs for fast access to cells relative to current position.
#         * \note position at (i-min_x) + (j-min_y)*div_x + (k-min_z)*div_x*div_y holds the index of the element at coordinates (i,j,k) in the grid (-1 if empty)
#       vector[int] getLeafLayout ()
#       /** \brief Returns the corresponding (i,j,k) coordinates in the grid of point (x,y,z).
#         * \param[in] x the X point coordinate to get the (i, j, k) index at
#         * \param[in] y the Y point coordinate to get the (i, j, k) index at
#         * \param[in] z the Z point coordinate to get the (i, j, k) index at
#       Eigen::Vector3i getGridCoordinates (float x, float y, float z) 
#       /** \brief Returns the index in the downsampled cloud corresponding to a given set of coordinates.
#         * \param[in] ijk the coordinates (i,j,k) in the grid (-1 if empty)
#       int getCentroidIndexAt (const Eigen::Vector3i &ijk)
#       /** \brief Provide the name of the field to be used for filtering data. In conjunction with  \a setFilterLimits,
#         * points having values outside this interval will be discarded.
#         * \param[in] field_name the name of the field that contains values used for filtering
#       void setFilterFieldName (const string &field_name)
#       /** \brief Get the name of the field used for filtering. */
#       std::string const getFilterFieldName ()
#       /** \brief Set the field filter limits. All points having field values outside this interval will be discarded.
#         * \param[in] limit_min the minimum allowed field value
#         * \param[in] limit_max the maximum allowed field value
#       void setFilterLimits (const double &limit_min, const double &limit_max)
#       /** \brief Get the field filter limits (min/max) set by the user. The default values are -FLT_MAX, FLT_MAX. 
#         * \param[out] limit_min the minimum allowed field value
#         * \param[out] limit_max the maximum allowed field value
#       void getFilterLimits (double &limit_min, double &limit_max)
#       /** \brief Set to true if we want to return the data outside the interval specified by setFilterLimits (min, max).
#         * Default: false.
#         * \param[in] limit_negative return data inside the interval (false) or outside (true)
#       void setFilterLimitsNegative (const bool limit_negative)
#       /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
#         * \param[out] limit_negative true if data \b outside the interval [min; max] is to be returned, false otherwise
#       void getFilterLimitsNegative (bool &limit_negative)
#       /** \brief Get whether the data outside the interval (min/max) is to be returned (true) or inside (false). 
#         * \return true if data \b outside the interval [min; max] is to be returned, false otherwise
#       bool getFilterLimitsNegative ()
#     protected:
#       /** \brief The size of a leaf. */
#       Eigen::Vector4f leaf_size_;
#       /** \brief Internal leaf sizes stored as 1/leaf_size_ for efficiency reasons. */ 
#       Eigen::Array4f inverse_leaf_size_;
#       /** \brief Set to true if all fields need to be downsampled, or false if just XYZ. */
#       bool downsample_all_data_;
#       /** \brief Set to true if leaf layout information needs to be saved in \a
#         * leaf_layout. 
#       bool save_leaf_layout_;
#       /** \brief The leaf layout information for fast access to cells relative
#         * to current position 
#       std::vector<int> leaf_layout_;
#       /** \brief The minimum and maximum bin coordinates, the number of
#         * divisions, and the division multiplier. 
#       Eigen::Vector4i min_b_, max_b_, div_b_, divb_mul_;
#       /** \brief The desired user filter field name. */
#       std::string filter_field_name_;
#       /** \brief The minimum allowed filter value a point will be considered from. */
#       double filter_limit_min_;
#       /** \brief The maximum allowed filter value a point will be considered from. */
#       double filter_limit_max_;
#       /** \brief Set to true if we want to return the data outside (\a filter_limit_min_;\a filter_limit_max_). Default: false. */
#       bool filter_limit_negative_;
#       /** \brief Downsample a Point Cloud using a voxelized grid approach
#         * \param[out] output the resultant point cloud
#       void applyFilter (PointCloud2 &output);
###

ctypedef VoxelGrid[cpp.PointXYZ] VoxelGrid_t
ctypedef VoxelGrid[cpp.PointXYZRGBA] VoxelGrid2_t

###
