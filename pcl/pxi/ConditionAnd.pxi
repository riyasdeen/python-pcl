﻿from libcpp.vector cimport vector
from libcpp cimport bool
# from libcpp.string cimport string

cimport pcl_defs as cpp
cimport pcl_filters as pclfil

from pcl_filters cimport CompareOp2
from boost_shared_ptr cimport shared_ptr
from boost_shared_ptr cimport sp_assign

# cdef class ConditionBase:
#     """
#     Must be constructed from the reference point cloud, which is copied, so
#     changed to pc are not reflected in ConditionAnd(pc).
#     """
#     cdef pclfil.ConditionBase_t *me2
# 
#     def __cinit__(self):
#         self.me2 = new pclfil.ConditionBase_t()
# 
#     def __dealloc__(self):
#         del self.me2

# cdef class ConditionAnd(ConditionBase):
cdef class ConditionAnd:
    """
    Must be constructed from the reference point cloud, which is copied, so
    changed to pc are not reflected in ConditionAnd(pc).
    """
    cdef pclfil.ConditionAnd_t *me
    # cdef pclfil.FieldComparisonConstPtr_t fieldCompPtr
    cdef pclfil.FieldComparisonPtr_t fieldCompPtr

    def __cinit__(self):
        self.me = new pclfil.ConditionAnd_t()

    def __dealloc__(self):
        del self.me

    # def add_Comparison(self, comparison):
    #     self.me.addComparison(comparison.this_ptr())

    def add_Comparison2(self, field_name, CompareOp2 compOp, double thresh):
        cdef bytes fname_ascii
        if isinstance(field_name, unicode):
            fname_ascii = field_name.encode("ascii")
        elif not isinstance(field_name, bytes):
            raise TypeError("field_name should be a string, got %r"
                            % field_name)
        else:
            fname_ascii = field_name

        # cdef pclfil.ComparisonBasePtr_t fieldCompConst = <pclfil.ComparisonBasePtr_t> new pclfil.FieldComparison_t(string(fname_ascii), compOp, thresh)
        # cdef pclfil.ComparisonBasePtr_t fieldCompConst = pclfil.FieldComparison_t(string(fname_ascii), compOp, thresh)
        # cdef pclfil.FieldComparisonPtr_t fieldCompConst
        # sp_assign(self.fieldCompPtr, new pclfil.FieldComparison_t(string(fname_ascii), compOp, thresh) )
        # self.fieldCompPtr = new pclfil.FieldComparison_t(string(fname_ascii), compOp, thresh)
        # self.me.addComparison(<shared_ptr[const pclfil.ComparisonBase[cpp.PointXYZ]]> fieldCompConst)
        # self.me.addComparison(fieldCompPtr)
        self.me.addComparison(<shared_ptr[const pclfil.ComparisonBase[cpp.PointXYZ]]> self.fieldCompPtr)
        # self.me.addComparison(deref(*fieldCompConst))
        # self.me.addComparison(fieldCompConst.thisptr())


