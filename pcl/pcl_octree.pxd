# -*- coding: utf-8 -*-

from libcpp cimport bool
from libcpp.vector cimport vector

# main
cimport pcl_defs as cpp
from boost_shared_ptr cimport shared_ptr

cimport eigen as eig
from vector cimport vector as vector2

###############################################################################
# Types
###############################################################################

### base class ###

# octree_base.h
# namespace pcl
#   namespace octree
# template<typename DataT, typename LeafT = OctreeContainerDataT<DataT>,
#                          typename BranchT = OctreeContainerEmpty<DataT> >
# class OctreeBase
cdef extern from "pcl/octree/octree_base.h" namespace "pcl::octree":
    cdef cppclass OctreeBase[T, Left, Branch]:
        OctreeBase()
        # OctreeBase (const OctreeBase& source) :
        # inline OctreeBase& operator = (const OctreeBase &source)
        # public:
        # typedef OctreeBase<DataT, OctreeContainerDataT<DataT>, OctreeContainerEmpty<DataT> > SingleObjLeafContainer;
        # typedef OctreeBase<DataT, OctreeContainerDataTVector<DataT>, OctreeContainerEmpty<DataT> > MultipleObjsLeafContainer;
        # typedef OctreeBase<DataT, LeafT, BranchT> OctreeT;
        # // iterators are friends
        # friend class OctreeIteratorBase<DataT, OctreeT> ;
        # friend class OctreeDepthFirstIterator<DataT, OctreeT> ;
        # friend class OctreeBreadthFirstIterator<DataT, OctreeT> ;
        # friend class OctreeLeafNodeIterator<DataT, OctreeT> ;
        # typedef OctreeBranchNode<BranchT> BranchNode;
        # typedef OctreeLeafNode<LeafT> LeafNode;
        # // Octree iterators
        # typedef OctreeDepthFirstIterator<DataT, OctreeT> Iterator;
        # typedef const OctreeDepthFirstIterator<DataT, OctreeT> ConstIterator;
        # typedef OctreeLeafNodeIterator<DataT, OctreeT> LeafNodeIterator;
        # typedef const OctreeLeafNodeIterator<DataT, OctreeT> ConstLeafNodeIterator;
        # typedef OctreeDepthFirstIterator<DataT, OctreeT> DepthFirstIterator;
        # typedef const OctreeDepthFirstIterator<DataT, OctreeT> ConstDepthFirstIterator;
        # typedef OctreeBreadthFirstIterator<DataT, OctreeT> BreadthFirstIterator;
        # typedef const OctreeBreadthFirstIterator<DataT, OctreeT> ConstBreadthFirstIterator;
        # void setMaxVoxelIndex (unsigned int maxVoxelIndex_arg)
        # /** \brief Set the maximum depth of the octree.
        #  *  \param depth_arg: maximum depth of octree
        # void setTreeDepth (unsigned int depth_arg);
        # /** \brief Get the maximum depth of the octree.
        #  *  \return depth_arg: maximum depth of octree
        # inline unsigned int getTreeDepth () const
        # /** \brief Enable dynamic octree structure
        #  *  \note Leaf nodes are kept as close to the root as possible and are only expanded if the number of DataT objects within a leaf node exceeds a fixed limit.
        #  *  \return maxObjsPerLeaf: maximum number of DataT objects per leaf
        # inline void enableDynamicDepth ( size_t maxObjsPerLeaf )
        # /** \brief Add a const DataT element to leaf node at (idxX, idxY, idxZ). If leaf node does not exist, it is created and added to the octree.
        #  *  \param idxX_arg: index of leaf node in the X axis.
        #  *  \param idxY_arg: index of leaf node in the Y axis.
        #  *  \param idxZ_arg: index of leaf node in the Z axis.
        #  *  \param data_arg: const reference to DataT object to be added.
        # void addData (unsigned int idxX_arg, unsigned int idxY_arg, unsigned int idxZ_arg, const DataT& data_arg)
        # /** \brief Retrieve a DataT element from leaf node at (idxX, idxY, idxZ). It returns false if leaf node does not exist.
        #  *  \param idxX_arg: index of leaf node in the X axis.
        #  *  \param idxY_arg: index of leaf node in the Y axis.
        #  *  \param idxZ_arg: index of leaf node in the Z axis.
        #  *  \param data_arg: reference to DataT object that contains content of leaf node if search was successful.
        #  *  \return "true" if leaf node search is successful, otherwise it returns "false".
        # bool getData (unsigned int idxX_arg, unsigned int idxY_arg, unsigned int idxZ_arg, DataT& data_arg) const 
        # /** \brief Check for the existence of leaf node at (idxX, idxY, idxZ).
        #  *  \param idxX_arg: index of leaf node in the X axis.
        #  *  \param idxY_arg: index of leaf node in the Y axis.
        #  *  \param idxZ_arg: index of leaf node in the Z axis.
        #  *  \return "true" if leaf node search is successful, otherwise it returns "false".
        # bool existLeaf (unsigned int idxX_arg, unsigned int idxY_arg, unsigned int idxZ_arg) const 
        # /** \brief Remove leaf node at (idxX_arg, idxY_arg, idxZ_arg).
        #  *  \param idxX_arg: index of leaf node in the X axis.
        #  *  \param idxY_arg: index of leaf node in the Y axis.
        #  *  \param idxZ_arg: index of leaf node in the Z axis.
        # void removeLeaf (unsigned int idxX_arg, unsigned int idxY_arg, unsigned int idxZ_arg)
        # /** \brief Return the amount of existing leafs in the octree.
        #  *  \return amount of registered leaf nodes.
        # inline std::size_t getLeafCount () const
        # /** \brief Return the amount of existing branches in the octree.
        #  *  \return amount of branch nodes.
        # inline std::size_t getBranchCount () const
        # /** \brief Delete the octree structure and its leaf nodes.
        #  *  \param freeMemory_arg: if "true", allocated octree nodes are deleted, otherwise they are pushed to the octree node pool
        # void deleteTree ( bool freeMemory_arg = true )
        # /** \brief Serialize octree into a binary output vector describing its branch node structure.
        #  *  \param binaryTreeOut_arg: reference to output vector for writing binary tree structure.
        # void serializeTree (vector[char]& binaryTreeOut_arg)
        # /** \brief Serialize octree into a binary output vector describing its branch node structure and push all DataT elements stored in the octree to a vector.
        #  * \param binaryTreeOut_arg: reference to output vector for writing binary tree structure.
        #  * \param dataVector_arg: reference of DataT vector that receives a copy of all DataT objects in the octree
        # void serializeTree (vector[char]& binaryTreeOut_arg, vector[T]& dataVector_arg);
        # /** \brief Outputs a vector of all DataT elements that are stored within the octree leaf nodes.
        #  *  \param dataVector_arg: reference to DataT vector that receives a copy of all DataT objects in the octree.
        # void serializeLeafs (std::vector<DataT>& dataVector_arg);
        # /** \brief Deserialize a binary octree description vector and create a corresponding octree structure. Leaf nodes are initialized with getDataTByKey(..).
        #  *  \param binaryTreeIn_arg: reference to input vector for reading binary tree structure.
        # void deserializeTree (std::vector<char>& binaryTreeIn_arg);
        # /** \brief Deserialize a binary octree description and create a corresponding octree structure. Leaf nodes are initialized with DataT elements from the dataVector.
        #  *  \param binaryTreeIn_arg: reference to input vector for reading binary tree structure.
        #  *  \param dataVector_arg: reference to DataT vector that provides DataT objects for initializing leaf nodes.
        # void deserializeTree (std::vector<char>& binaryTreeIn_arg, std::vector<DataT>& dataVector_arg);
        # protected:
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Protected octree methods based on octree keys
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Virtual method for generating an octree key for a given DataT object.
        #   * \param[in] data_arg reference to DataT object
        #   * \param[in] key_arg write generated octree key to this octree key reference
        #   * \return "true" if octree could be generated based on DataT object; "false" otherwise
        #   */
        # virtual bool genOctreeKeyForDataT (const DataT &, OctreeKey &) const
        # /** \brief Virtual method for initializing new leaf node during deserialization (in case no DataT information is provided)
        #   * \param[in] key_arg write generated octree key to this octree key reference
        #   * \param[in] data_arg generated DataT object
        #   * \return "true" if DataT object could be generated; "false" otherwise
        #   */
        # virtual bool genDataTByOctreeKey (const OctreeKey &, DataT &) const
        # /** \brief Add DataT object to leaf node at octree key.
        #  *  \param key_arg: octree key addressing a leaf node.
        #  *  \param data_arg: DataT object to be added.
        #  * */
        # inline void addData (const OctreeKey& key_arg, const DataT& data_arg)
        # /** \brief Find leaf node
        #  *  \param key_arg: octree key addressing a leaf node.
        #  *  \return pointer to leaf node. If leaf node is not found, this pointer returns 0.
        #  * */
        # inline LeafNode* findLeaf (const OctreeKey& key_arg) const
        # /** \brief Check for existance of a leaf node in the octree
        #  *  \param key_arg: octree key addressing a leaf node.
        #  *  \return "true" if leaf node is found; "false" otherwise
        #  * */
        # inline bool existLeaf (const OctreeKey& key_arg) const
        # /** \brief Remove leaf node from octree
        #  *  \param key_arg: octree key addressing a leaf node.
        #  * */
        # inline void removeLeaf (const OctreeKey& key_arg)
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Branch node accessor inline functions
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Retrieve root node */
        # OctreeNode* getRootNode () const
        # /** \brief Check if branch is pointing to a particular child node
        #  *  \param branch_arg: reference to octree branch class
        #  *  \param childIdx_arg: index to child node
        #  *  \return "true" if pointer to child node exists; "false" otherwise
        #  * */
        # inline bool branchHasChild (const BranchNode& branch_arg, unsigned char childIdx_arg) const
        # /** \brief Retrieve a child node pointer for child node at childIdx.
        #  * \param branch_arg: reference to octree branch class
        #  * \param childIdx_arg: index to child node
        #  * \return pointer to octree child node class
        #  */
        # inline OctreeNode* getBranchChildPtr (const BranchNode& branch_arg, unsigned char childIdx_arg) const
        # /** \brief Assign new child node to branch
        #  *  \param branch_arg: reference to octree branch class
        #  *  \param childIdx_arg: index to child node
        #  *  \param newChild_arg: pointer to new child node
        #  * */
        # inline void setBranchChildPtr (BranchNode& branch_arg, unsigned char childIdx_arg, OctreeNode* newChild_arg)
        # /** \brief Get data from octree node
        #  *  \param node_arg: node in octree
        #  *  \param data_arg: obtain single DataT object from octree node
        #  * */
        # inline void getDataFromOctreeNode (const OctreeNode* node_arg, DataT& data_arg)
        # /** \brief Get data from octree node
        #  *  \param node_arg: node in octree
        #  *  \param data_arg: obtain vector of all DataT objects stored in octree node
        #  * */
        # inline void getDataFromOctreeNode (const OctreeNode* node_arg, std::vector<DataT>& data_arg)
        # /** \brief Get data size of octree node container
        #  *  \param node_arg: node in octree
        #  *  \return data_arg: returns number of DataT objects stored in node container
        #  * */
        # inline size_t getDataSizeFromOctreeNode (const OctreeNode* node_arg)
        # /** \brief Generate bit pattern reflecting the existence of child node pointers
        #  *  \param branch_arg: reference to octree branch class
        #  *  \return a single byte with 8 bits of child node information
        #  * */
        # inline char getBranchBitPattern (const BranchNode& branch_arg) const
        # /** \brief Delete child node and all its subchilds from octree
        #  *  \param branch_arg: reference to octree branch class
        #  *  \param childIdx_arg: index to child node
        #  * */
        # inline void deleteBranchChild (BranchNode& branch_arg, unsigned char childIdx_arg)
        # /** \brief Delete branch and all its subchilds from octree
        #  *  \param branch_arg: reference to octree branch class
        #  * */
        # inline void deleteBranch (BranchNode& branch_arg)
        # /** \brief Create and add a new branch child to a branch class
        #  *  \param branch_arg: reference to octree branch class
        #  *  \param childIdx_arg: index to child node
        #  *  \param newBranchChild_arg: write a pointer of new branch child to this reference
        #  * */
        # inline void createBranchChild (BranchNode& branch_arg, unsigned char childIdx_arg, BranchNode*& newBranchChild_arg)
        # /** \brief Create and add a new leaf child to a branch class
        #  *  \param branch_arg: reference to octree branch class
        #  *  \param childIdx_arg: index to child node
        #  *  \param newLeafChild_arg: writes a pointer of new leaf child to this reference
        #  * */
        # inline void createLeafChild (BranchNode& branch_arg, unsigned char childIdx_arg, LeafNode*& newLeafChild_arg)
        # /** \brief Reset branch class
        #  *  \param branch_arg: reference to octree branch class
        #  * */
        # inline void branchReset (BranchNode& branch_arg)
        # /** \brief Delete all branch nodes and leaf nodes from octree node pools
        #  * */
        # inline void poolCleanUp ()
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Recursive octree methods
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Create a leaf node at octree key. If leaf node does already exist, it is returned.
        #  *  \param key_arg: reference to an octree key
        #  *  \param depthMask_arg: depth mask used for octree key analysis and for branch depth indicator
        #  *  \param data_arg data to be added
        #  *  \param branch_arg: current branch node
        #  **/
        # void addDataToLeafRecursive (const OctreeKey& key_arg, unsigned int depthMask_arg, const DataT& data_arg, BranchNode* branch_arg);
        # /** \brief Recursively search for a given leaf node and return a pointer.
        #  *  \note  If leaf node does not exist, a 0 pointer is returned.
        #  *  \param key_arg: reference to an octree key
        #  *  \param depthMask_arg: depth mask used for octree key analysis and for branch depth indicator
        #  *  \param branch_arg: current branch node
        #  *  \param result_arg: pointer to leaf node class
        #  **/
        # void findLeafRecursive (const OctreeKey& key_arg, unsigned int depthMask_arg, BranchNode* branch_arg, LeafNode*& result_arg) const;
        # /** \brief Recursively search and delete leaf node
        #  *  \param key_arg: reference to an octree key
        #  *  \param depthMask_arg: depth mask used for octree key analysis and branch depth indicator
        #  *  \param branch_arg: current branch node
        #  *  \return "true" if branch does not contain any childs; "false" otherwise. This indicates if current branch can be deleted, too.
        #  **/
        # bool deleteLeafRecursive (const OctreeKey& key_arg, unsigned int depthMask_arg, BranchNode* branch_arg);
        # /** \brief Recursively explore the octree and output binary octree description together with a vector of leaf node DataT content.
        #   *  \param binaryTreeOut_arg: binary output vector
        #   *  \param branch_arg: current branch node
        #   *  \param key_arg: reference to an octree key
        #  *  \param dataVector_arg: writes DataT content to this DataT vector.
        #  **/
        # void serializeTreeRecursive (const BranchNode* branch_arg, OctreeKey& key_arg,
        #     std::vector<char>* binaryTreeOut_arg,
        #     typename std::vector<DataT>* dataVector_arg) const;
        #  /** \brief Rebuild an octree based on binary XOR octree description and DataT objects for leaf node initialization.
        #   *  \param binaryTreeIn_arg: iterator to input vector
        #   *  \param branch_arg: current branch node
        #   *  \param depthMask_arg: depth mask used for octree key analysis and branch depth indicator
        #   *  \param key_arg: reference to an octree key
        #   *  \param dataVectorIterator_arg: iterator pointing to current DataT object to be added to a leaf node
        #   *  \param dataVectorEndIterator_arg: iterator pointing to last object in DataT input vector.
        #   **/
        #  void deserializeTreeRecursive (BranchNode* branch_arg,
        #      unsigned int depthMask_arg, OctreeKey& key_arg,
        #      typename std::vector<char>::const_iterator& binaryTreeIT_arg,
        #      typename std::vector<char>::const_iterator& binaryTreeIT_End_arg,
        #      typename std::vector<DataT>::const_iterator* dataVectorIterator_arg,
        #      typename std::vector<DataT>::const_iterator* dataVectorEndIterator_arg);
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Serialization callbacks
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Callback executed for every leaf node during serialization
        #  **/
        # virtual void serializeTreeCallback (const LeafNode &, const OctreeKey &) const
        # /** \brief Callback executed for every leaf node during deserialization
        #  **/
        # virtual void deserializeTreeCallback (LeafNode&, const OctreeKey&)
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Helpers
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Helper function to calculate the binary logarithm
        #  * \param n_arg: some value
        #  * \return binary logarithm (log2) of argument n_arg
        #  */
        # inline double Log2 (double n_arg)
        # /** \brief Test if octree is able to dynamically change its depth. This is required for adaptive bounding box adjustment.
        #  *  \return "true"
        #  **/
        # inline bool octreeCanResize ()
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Globals
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Amount of leaf nodes   **/
        # std::size_t leafCount_;
        # /** \brief Amount of branch nodes   **/
        # std::size_t branchCount_;
        # /** \brief Amount of objects assigned to leaf nodes   **/
        # std::size_t objectCount_;
        # /** \brief Pointer to root branch node of octree   **/
        # BranchNode* rootNode_;
        # /** \brief Amount of DataT objects per leafNode before expanding branch
        #  *  \note zero indicates a fixed/maximum depth octree structure
        #  * **/
        # std::size_t maxObjsPerLeaf_;
        # /** \brief Depth mask based on octree depth   **/
        # unsigned int depthMask_;
        # /** \brief Octree depth */
        # unsigned int octreeDepth_;
        # /** \brief key range */
        # OctreeKey maxKey_;
        # /** \brief Pool of unused branch nodes   **/
        # OctreeNodePool<BranchNode> branchNodePool_;
        # /** \brief Pool of unused branch nodes   **/
        # OctreeNodePool<LeafNode> leafNodePool_;
###

### Inheritance class ###

# octree.h
# header include
###

# Version 1.7.2
# octree2buf_base.h
###

# octree_container.h
# namespace pcl
# namespace octree
# template<typename DataT>
# class OctreeContainerEmpty
cdef extern from "pcl/octree/octree_container.h" namespace "pcl::octree":
    cdef cppclass OctreeContainerEmpty[DataT]:
        OctreeContainerEmpty()
        # OctreeContainerEmpty (const OctreeContainerEmpty&)
        # public:
        # /** \brief Octree deep copy method */
        # virtual OctreeContainerEmpty *deepCopy () const
        # /** \brief Empty setData data implementation. This leaf node does not store any data.
        # void setData (const DataT&)
        # /** \brief Empty getData data vector implementation as this leaf node does not store any data.
        # void getData (DataT&) const
        # /** \brief Empty getData data vector implementation as this leaf node does not store any data. \
        # * \param[in] dataVector_arg reference to dummy DataT vector that is extended with leaf node DataT elements.
        # void getData (std::vector<DataT>&) const
        # /** \brief Get size of container (number of DataT objects)
        #  * \return number of DataT elements in leaf node container.
        # size_t getSize () const
        # /** \brief Empty reset leaf node implementation as this leaf node does not store any data. */
        # void reset ()
###

# # template<typename DataT>
# # class OctreeContainerDataT
# cdef extern from "pcl/octree/octree_container.h" namespace "pcl::octree":
#     cdef cppclass OctreeContainerDataT[DataT]:
#         OctreeContainerDataT()
#         # OctreeContainerDataT (const OctreeContainerDataT& source) :
#         # public:
#         # /** \brief Octree deep copy method */
#         # virtual OctreeContainerDataT* deepCopy () const
#         # /** \brief Copies a DataT element to leaf node memorye.
#         #  * \param[in] data_arg reference to DataT element to be stored within leaf node.
#         # void setData (const DataT& data_arg)
#         # /** \brief Adds leaf node DataT element to dataVector vector of type DataT.
#         #  * \param[in] dataVector_arg: reference to DataT type to obtain the most recently added leaf node DataT element.
#         # void getData (DataT& dataVector_arg) const
#         # /** \brief Adds leaf node DataT element to dataVector vector of type DataT.
#         #  * \param[in] dataVector_arg: reference to DataT vector that is to be extended with leaf node DataT elements.
#         # void getData (vector<DataT>& dataVector_arg) const
#         # /** \brief Get size of container (number of DataT objects)
#         #  * \return number of DataT elements in leaf node container.
#         # size_t getSize () const
#         # /** \brief Reset leaf node memory to zero. */
#         # void reset ()
#         # protected:
#         # /** \brief Leaf node DataT storage. */
#         # DataT data_;
#         # /** \brief Bool indicating if leaf node is empty or not. */
#         # bool isEmpty_;
# 
# # template<typename DataT>
# # class OctreeContainerDataTVector
# cdef extern from "pcl/octree/octree_container.h" namespace "pcl::octree":
#     cdef cppclass OctreeContainerDataTVector[DataT]:
#         OctreeContainerDataTVector()
#         # OctreeContainerDataTVector (const OctreeContainerDataTVector& source) :
#         # public:
#         # /** \brief Octree deep copy method */
#         # virtual OctreeContainerDataTVector *deepCopy () const
#         # /** \brief Pushes a DataT element to internal DataT vector.
#         #  * \param[in] data_arg reference to DataT element to be stored within leaf node.
#         #  */
#         # void setData (const DataT& data_arg)
#         # /** \brief Receive the most recent DataT element that was pushed to the internal DataT vector.
#         #  * \param[in] data_arg reference to DataT type to obtain the most recently added leaf node DataT element.
#         #  */
#         # void getData (DataT& data_arg) const
#         # /** \brief Concatenate the internal DataT vector to vector argument dataVector_arg.
#         #  * \param[in] dataVector_arg: reference to DataT vector that is to be extended with leaf node DataT elements.
#         #  */
#         # void getData (vector[DataT]& dataVector_arg) const
#         # /** \brief Return const reference to internal DataT vector
#         #  * \return  const reference to internal DataT vector
#         # const vector[DataT]& getDataTVector () const
#         # /** \brief Get size of container (number of DataT objects)
#         #  * \return number of DataT elements in leaf node container.
#         # size_t getSize () const
#         # /** \brief Reset leaf node. Clear DataT vector.*/
#         # void reset ()
#         # protected:
#         # /** \brief Leaf node DataT vector. */
#         # vector[DataT] leafDataTVector_;
# ###
# 
# # octree_impl.h
# # impl header include
# ###
# 
# # octree_iterator.h
# # namespace pcl
# # namespace octree
# #   template<typename DataT, typename OctreeT>
# #       class OctreeIteratorBase : public std::iterator<std::forward_iterator_tag, const OctreeNode, void, const OctreeNode*, const OctreeNode&>
# cdef extern from "pcl/octree/octree_iterator.h" namespace "pcl::octree":
#     cdef cppclass OctreeIteratorBase[DataT, OctreeT]:
#         OctreeIteratorBase()
#         # explicit OctreeIteratorBase (OctreeT& octree_arg)
#         # OctreeIteratorBase (const OctreeIteratorBase& src) :
#         # inline OctreeIteratorBase& operator = (const OctreeIteratorBase& src)
#         # public:
#         # typedef typename OctreeT::LeafNode LeafNode;
#         # typedef typename OctreeT::BranchNode BranchNode;
#         # /** \brief initialize iterator globals */
#         # inline void reset ()
#         # /** \brief Get octree key for the current iterator octree node
#         #  * \return octree key of current node
#         # inline const OctreeKey& getCurrentOctreeKey () const
#         # /** \brief Get the current depth level of octree
#         #  * \return depth level
#         # inline unsigned int getCurrentOctreeDepth () const
#         # /** \brief Get the current octree node
#         #  * \return pointer to current octree node
#         # inline OctreeNode* getCurrentOctreeNode () const
#         # /** \brief *operator.
#         #  * \return pointer to the current octree node
#         # inline OctreeNode* operator* () const
#         # /** \brief check if current node is a branch node
#         #  * \return true if current node is a branch node, false otherwise
#         # inline bool isBranchNode () const
#         # /** \brief check if current node is a branch node
#         #  * \return true if current node is a branch node, false otherwise
#         # inline bool isLeafNode () const
#         # /** \brief Get bit pattern of children configuration of current node
#         #  * \return bit pattern (byte) describing the existence of 8 children of the current node
#         # inline char getNodeConfiguration () const
#         # /** \brief Method for retrieving a single DataT element from the octree leaf node
#         #  * \param[in] data_arg reference to return pointer of leaf node DataT element.
#         # virtual void getData (DataT& data_arg) const
#         # /** \brief Method for retrieving a vector of DataT elements from the octree laef node
#         #  * \param[in] dataVector_arg reference to DataT vector that is extended with leaf node DataT elements.
#         # virtual void getData (std::vector<DataT>& dataVector_arg) const
#         # /** \brief Method for retrieving the size of the DataT vector from the octree laef node
#         # virtual std::size_t getSize () const
#         # /** \brief get a integer identifier for current node (note: identifier depends on tree depth).
#         #  * \return node id.
#         # virtual unsigned long getNodeID () const
#         # protected:
#         # /** \brief Reference to octree class. */
#         # OctreeT& octree_;
#         # /** Pointer to current octree node. */
#         # OctreeNode* currentNode_;
#         # /** Depth level in the octree structure. */
#         # unsigned int currentOctreeDepth_;
#         # /** Octree key for current octree node. */
#         # OctreeKey currentOctreeKey_;
# ###
# 
# # template<typename DataT, typename OctreeT>
# # class OctreeDepthFirstIterator : public OctreeIteratorBase<DataT, OctreeT>
# cdef extern from "pcl/octree/octree_iterator.h" namespace "pcl::octree":
#     cdef cppclass OctreeDepthFirstIterator[DataT, OctreeT](OctreeIteratorBase[DataT, OctreeT]):
#         OctreeDepthFirstIterator()
#         # explicit OctreeDepthFirstIterator (OctreeT& octree_arg)
#         # public:
#         # typedef typename OctreeIteratorBase<DataT, OctreeT>::LeafNode LeafNode;
#         # typedef typename OctreeIteratorBase<DataT, OctreeT>::BranchNode BranchNode;
#         # /** \brief Reset the iterator to the root node of the octree
#         # virtual void reset ();
#         # /** \brief Preincrement operator.
#         #  * \note recursively step to next octree node
#         # OctreeDepthFirstIterator& operator++ ();
#         # /** \brief postincrement operator.
#         #  * \note recursively step to next octree node
#         # inline OctreeDepthFirstIterator operator++ (int)
#         # /** \brief Skip all child voxels of current node and return to parent node.
#         # void skipChildVoxels ();
#         # protected:
#         # /** Child index at current octree node. */
#         # unsigned char currentChildIdx_;
#         # /** Stack structure. */
#         # std::vector<std::pair<OctreeNode*, unsigned char> > stack_;
# 

# 
# # template<typename DataT, typename OctreeT>
# # class OctreeBreadthFirstIterator : public OctreeIteratorBase<DataT, OctreeT>
# cdef extern from "pcl/octree/octree_iterator.h" namespace "pcl::octree":
#     cdef cppclass OctreeBreadthFirstIterator[DataT, OctreeT](OctreeIteratorBase[DataT, OctreeT]):
#         OctreeDepthFirstIterator()
#         # explicit OctreeBreadthFirstIterator (OctreeT& octree_arg);
#         # // public typedefs
#         # typedef typename OctreeIteratorBase<DataT, OctreeT>::BranchNode BranchNode;
#         # typedef typename OctreeIteratorBase<DataT, OctreeT>::LeafNode LeafNode;
#         # struct FIFOElement
#         # {
#         #   OctreeNode* node;
#         #   OctreeKey key;
#         #   unsigned int depth;
#         # };
#         # public:
#         # /** \brief Reset the iterator to the root node of the octree
#         # void reset ();
#         # /** \brief Preincrement operator.
#         #  * \note step to next octree node
#         # OctreeBreadthFirstIterator& operator++ ();
#         # /** \brief postincrement operator.
#         #  * \note step to next octree node
#         # inline OctreeBreadthFirstIterator operator++ (int)
#         # protected:
#         # /** \brief Add children of node to FIFO
#         #  * \param[in] node: node with children to be added to FIFO
#         # void addChildNodesToFIFO (const OctreeNode* node);
#         # /** FIFO list */
#         # std::deque<FIFOElement> FIFO_;
# 
# # template<typename DataT, typename OctreeT>
# # class OctreeLeafNodeIterator : public OctreeDepthFirstIterator<DataT, OctreeT>
# cdef extern from "pcl/octree/octree_iterator.h" namespace "pcl::octree":
#     cdef cppclass OctreeLeafNodeIterator[DataT, OctreeT](OctreeDepthFirstIterator[DataT, OctreeT]):
#         OctreeLeafNodeIterator()
#         # explicit OctreeLeafNodeIterator (OctreeT& octree_arg)
#         # typedef typename OctreeDepthFirstIterator<DataT, OctreeT>::BranchNode BranchNode;
#         # typedef typename OctreeDepthFirstIterator<DataT, OctreeT>::LeafNode LeafNode;
#         # public:
#         # /** \brief Constructor.
#         #  * \param[in] octree_arg Octree to be iterated. Initially the iterator is set to its root node.
#         # /** \brief Reset the iterator to the root node of the octree
#         # inline void reset ()
#         # /** \brief Preincrement operator.
#         #  * \note recursively step to next octree leaf node
#         # inline OctreeLeafNodeIterator& operator++ ()
#         # /** \brief postincrement operator.
#         #  * \note step to next octree node
#         # inline OctreeLeafNodeIterator operator++ (int)
#         # /** \brief *operator.
#         #  * \return pointer to the current octree leaf node
#         # OctreeNode* operator* () const
# ###
# 
# # octree_key.h
# # namespace pcl
# # namespace octree
# # class OctreeKey
# cdef extern from "pcl/octree/octree_key.h" namespace "pcl::octree":
#     cdef cppclass OctreeKey:
#         OctreeKey()
#         # OctreeKey (unsigned int keyX, unsigned int keyY, unsigned int keyZ) :
#         # OctreeKey (const OctreeKey& source) :
#         # public:
#         # /** \brief Operator== for comparing octree keys with each other.
#         # *  \return "true" if leaf node indices are identical; "false" otherwise.
#         # bool operator == (const OctreeKey& b) const
#         # /** \brief Operator<= for comparing octree keys with each other.
#         # *  \return "true" if key indices are not greater than the key indices of b  ; "false" otherwise.
#         # bool operator <= (const OctreeKey& b) const
#         # /** \brief Operator>= for comparing octree keys with each other.
#         # *  \return "true" if key indices are not smaller than the key indices of b  ; "false" otherwise.
#         # bool operator >= (const OctreeKey& b) const
#         # /** \brief push a child node to the octree key
#         # *  \param[in] childIndex index of child node to be added (0-7)
#         # */
#         # inline void pushBranch (unsigned char childIndex)
#         # /** \brief pop child node from octree key
#         # inline void popBranch ()
#         # /** \brief get child node index using depthMask
#         # *  \param[in] depthMask bit mask with single bit set at query depth
#         # *  \return child node index
#         # * */
#         # inline unsigned char getChildIdxWithDepthMask (unsigned int depthMask) const
#         # // Indices addressing a voxel at (X, Y, Z)
#         # unsigned int x;
#         # unsigned int y;
#         # unsigned int z;
# ###
# 
# # octree_node_pool.h
# # namespace pcl
# # namespace octree
# # template<typename NodeT>
# # class OctreeNodePool
# cdef extern from "pcl/octree/octree_node_pool.h" namespace "pcl::octree":
#     cdef cppclass OctreeNodePool[T]:
#         OctreeNodePool()
#         # public:
#         # /** \brief Push node to pool
#         # *  \param childIdx_arg: pointer of noe
#         # inline void pushNode (NodeT* node_arg)
#         # /** \brief Pop node from pool - Allocates new nodes if pool is empty
#         # *  \return Pointer to octree node
#         # inline NodeT* popNode ()
#         # /** \brief Delete all nodes in pool
#         # */
#         # void deletePool ()
#         # protected:
#         # vector<NodeT*> nodePool_;
# ###
# 
# # NG
# # octree_nodes.h
# # namespace pcl
# # namespace octree
# #     // enum of node types within the octree
# #     enum node_type_t
# #     {
# #       BRANCH_NODE, LEAF_NODE
# #     };
# # namespace pcl
# # namespace octree
# # class PCL_EXPORTS OctreeNode
# #       public:
# #       OctreeNode ()
# #       /** \brief Pure virtual method for receiving the type of octree node (branch or leaf)  */
# #       virtual node_type_t getNodeType () const = 0;
# #       /** \brief Pure virtual method to perform a deep copy of the octree */
# #       virtual OctreeNode* deepCopy () const = 0;
# # template<typename ContainerT>
# # class OctreeLeafNode : public OctreeNode, public ContainerT
# # cdef cppclass OctreeLeafNode[T](OctreeNode)(ContainerT):
# # cdef extern from "pcl/octree/octree_nodes.h" namespace "pcl::octree":
# #     cdef cppclass OctreeLeafNode[T]:
# #         OctreeLeafNode()
#         # OctreeLeafNode (const OctreeLeafNode& source) :
#         # public:
#         # using ContainerT::getSize;
#         # using ContainerT::getData;
#         # using ContainerT::setData;
#         # /** \brief Method to perform a deep copy of the octree */
#         # virtual OctreeLeafNode<ContainerT>* deepCopy () const
#         # /** \brief Get the type of octree node. Returns LEAVE_NODE type */
#         # virtual node_type_t getNodeType () const
#         # /** \brief Reset node */
#         # inline void reset ()
# 
# # template<typename ContainerT>
# # class OctreeBranchNode : public OctreeNode, ContainerT
# # cdef extern from "pcl/octree/octree_nodes.h" namespace "pcl::octree":
# #     cdef cppclass OctreeBranchNode[ContainerT]:
# #         OctreeBranchNode()
#         # OctreeBranchNode (const OctreeBranchNode& source)
#         # inline OctreeBranchNode& operator = (const OctreeBranchNode &source)
#         # public:
#         # using ContainerT::getSize;
#         # using ContainerT::getData;
#         # using ContainerT::setData;
#         # /** \brief Octree deep copy method */
#         # virtual OctreeBranchNode* deepCopy () const
#         # inline void reset ()
#         # /** \brief Access operator.
#         #  *  \param childIdx_arg: index to child node
#         #  *  \return OctreeNode pointer
#         #  * */
#         # inline OctreeNode*& operator[] (unsigned char childIdx_arg)
#         # /** \brief Get pointer to child
#         #  *  \param childIdx_arg: index to child node
#         #  *  \return OctreeNode pointer
#         #  * */
#         # inline OctreeNode* getChildPtr (unsigned char childIdx_arg) const
#         # /** \brief Get pointer to child
#         #  *  \return OctreeNode pointer
#         #  * */
#         # inline void setChildPtr (OctreeNode* child, unsigned char index)
#         # /** \brief Check if branch is pointing to a particular child node
#         #  *  \param childIdx_arg: index to child node
#         #  *  \return "true" if pointer to child node exists; "false" otherwise
#         #  * */
#         # inline bool hasChild (unsigned char childIdx_arg) const
#         # /** \brief Get the type of octree node. Returns LEAVE_NODE type */
#         # virtual node_type_t getNodeType () const
#         # protected:
#         # OctreeNode* childNodeArray_[8];
###

# octree_pointcloud.h
cdef extern from "pcl/octree/octree_pointcloud.h" namespace "pcl::octree":
    cdef cppclass OctreePointCloud[T]:
        OctreePointCloud(double)
        void setInputCloud (shared_ptr[cpp.PointCloud[T]])
        void defineBoundingBox()
        void defineBoundingBox(double, double, double, double, double, double)
        void addPointsFromInputCloud()
        void deleteTree()
        bool isVoxelOccupiedAtPoint(double, double, double)
        # convert cpp code 
        # int getOccupiedVoxelCenters(eig.AlignedPointTVector_t)
        # int getOccupiedVoxelCenters(eig.AlignedPointTVector_PointXYZI_t)
        # int getOccupiedVoxelCenters(eig.AlignedPointTVector_PointXYZRGB_t)
        # int getOccupiedVoxelCenters(eig.AlignedPointTVector_PointXYZRGBA_t)
        int getOccupiedVoxelCenters(vector2[T, eig.aligned_allocator[T]])
        # convert cpp code 
        # void deleteVoxelAtPoint(cpp.PointXYZ)
        # void deleteVoxelAtPoint(cpp.PointXYZI)
        # void deleteVoxelAtPoint(cpp.PointXYZRGB)
        # void deleteVoxelAtPoint(cpp.PointXYZRGBA)
        void deleteVoxelAtPoint(T)

ctypedef OctreePointCloud[cpp.PointXYZ] OctreePointCloud_t
ctypedef OctreePointCloud[cpp.PointXYZI] OctreePointCloud_PointXYZI_t
ctypedef OctreePointCloud[cpp.PointXYZRGB] OctreePointCloud_PointXYZRGB_t
ctypedef OctreePointCloud[cpp.PointXYZRGBA] OctreePointCloud_PointXYZRGBA_t

# namespace pcl
# namespace octree
# template<typename PointT, typename LeafT = OctreeContainerDataTVector<int>,
#       typename BranchT = OctreeContainerEmpty<int>,
#       typename OctreeT = OctreeBase<int, LeafT, BranchT> >
# class OctreePointCloud : public OctreeT
# cdef extern from "pcl/octree/octree_pointcloud.h" namespace "pcl::octree":
#     cdef cppclass OctreePointCloud[T, LeafT, BranchT, OctreeT](OctreeT):
        # OctreePointCloud(double)
        # OctreePointCloud (const double resolution_arg);
        # // iterators are friends
        # friend class OctreeIteratorBase<int, OctreeT> ;
        # friend class OctreeDepthFirstIterator<int, OctreeT> ;
        # friend class OctreeBreadthFirstIterator<int, OctreeT> ;
        # friend class OctreeLeafNodeIterator<int, OctreeT> ;
        # public:
        # typedef OctreeT Base;
        # typedef typename OctreeT::LeafNode LeafNode;
        # typedef typename OctreeT::BranchNode BranchNode;
        # // Octree iterators
        # typedef OctreeDepthFirstIterator<int, OctreeT> Iterator;
        # typedef const OctreeDepthFirstIterator<int, OctreeT> ConstIterator;
        # typedef OctreeLeafNodeIterator<int, OctreeT> LeafNodeIterator;
        # typedef const OctreeLeafNodeIterator<int, OctreeT> ConstLeafNodeIterator;
        # typedef OctreeDepthFirstIterator<int, OctreeT> DepthFirstIterator;
        # typedef const OctreeDepthFirstIterator<int, OctreeT> ConstDepthFirstIterator;
        # typedef OctreeBreadthFirstIterator<int, OctreeT> BreadthFirstIterator;
        # typedef const OctreeBreadthFirstIterator<int, OctreeT> ConstBreadthFirstIterator;
        # /** \brief Octree pointcloud constructor.
        #  * \param[in] resolution_arg octree resolution at lowest octree level
        # // public typedefs
        # typedef boost::shared_ptr<std::vector<int> > IndicesPtr;
        # typedef boost::shared_ptr<const std::vector<int> > IndicesConstPtr;
        # typedef pcl::PointCloud<PointT> PointCloud;
        # typedef boost::shared_ptr<PointCloud> PointCloudPtr;
        # typedef boost::shared_ptr<const PointCloud> PointCloudConstPtr;
        # // public typedefs for single/double buffering
        # typedef OctreePointCloud<PointT, LeafT, OctreeBase<int, LeafT> > SingleBuffer;
        # typedef OctreePointCloud<PointT, LeafT, Octree2BufBase<int, LeafT> > DoubleBuffer;
        # // Boost shared pointers
        # typedef boost::shared_ptr<OctreePointCloud<PointT, LeafT, OctreeT> > Ptr;
        # typedef boost::shared_ptr<const OctreePointCloud<PointT, LeafT, OctreeT> > ConstPtr;
        # // Eigen aligned allocator
        # typedef std::vector<PointT, Eigen::aligned_allocator<PointT> > AlignedPointTVector;
        # /** \brief Provide a pointer to the input data set.
        #  * \param[in] cloud_arg the const boost shared pointer to a PointCloud message
        #  * \param[in] indices_arg the point indices subset that is to be used from \a cloud - if 0 the whole point cloud is used
        #  */
        # inline void setInputCloud (const PointCloudConstPtr &cloud_arg, const IndicesConstPtr &indices_arg = IndicesConstPtr ())
        # /** \brief Get a pointer to the vector of indices used.
        #  * \return pointer to vector of indices used.
        #  */
        # inline IndicesConstPtr const getIndices () const
        # /** \brief Get a pointer to the input point cloud dataset.
        #  * \return pointer to pointcloud input class.
        #  */
        # inline PointCloudConstPtr getInputCloud () const
        # /** \brief Set the search epsilon precision (error bound) for nearest neighbors searches.
        #  * \param[in] eps precision (error bound) for nearest neighbors searches
        #  */
        # inline void setEpsilon (double eps)
        # /** \brief Get the search epsilon precision (error bound) for nearest neighbors searches. */
        # inline double getEpsilon () const
        # /** \brief Set/change the octree voxel resolution
        #  * \param[in] resolution_arg side length of voxels at lowest tree level
        #  */
        # inline void setResolution (double resolution_arg)
        # /** \brief Get octree voxel resolution
        #  * \return voxel resolution at lowest tree level
        #  */
        # inline double getResolution () const
        # /** \brief Get the maximum depth of the octree.
        #  *  \return depth_arg: maximum depth of octree
        #  * */
        # inline unsigned int getTreeDepth () const
        # /** \brief Add points from input point cloud to octree. */
        # void addPointsFromInputCloud ();
        # /** \brief Add point at given index from input point cloud to octree. Index will be also added to indices vector.
        #  * \param[in] pointIdx_arg index of point to be added
        #  * \param[in] indices_arg pointer to indices vector of the dataset (given by \a setInputCloud)
        # void addPointFromCloud (const int pointIdx_arg, IndicesPtr indices_arg);
        # /** \brief Add point simultaneously to octree and input point cloud.
        #  *  \param[in] point_arg point to be added
        #  *  \param[in] cloud_arg pointer to input point cloud dataset (given by \a setInputCloud)
        # void addPointToCloud (const PointT& point_arg, PointCloudPtr cloud_arg);
        # /** \brief Add point simultaneously to octree and input point cloud. A corresponding index will be added to the indices vector.
        #  * \param[in] point_arg point to be added
        #  * \param[in] cloud_arg pointer to input point cloud dataset (given by \a setInputCloud)
        #  * \param[in] indices_arg pointer to indices vector of the dataset (given by \a setInputCloud)
        # void addPointToCloud (const PointT& point_arg, PointCloudPtr cloud_arg, IndicesPtr indices_arg);
        # /** \brief Check if voxel at given point exist.
        #  * \param[in] point_arg point to be checked
        #  * \return "true" if voxel exist; "false" otherwise
        # bool isVoxelOccupiedAtPoint (const PointT& point_arg) const;
        # /** \brief Delete the octree structure and its leaf nodes.
        #  *  \param freeMemory_arg: if "true", allocated octree nodes are deleted, otherwise they are pushed to the octree node pool
        # void deleteTree (bool freeMemory_arg = false)
        # /** \brief Check if voxel at given point coordinates exist.
        #  * \param[in] pointX_arg X coordinate of point to be checked
        #  * \param[in] pointY_arg Y coordinate of point to be checked
        #  * \param[in] pointZ_arg Z coordinate of point to be checked
        #  * \return "true" if voxel exist; "false" otherwise
        # bool isVoxelOccupiedAtPoint (const double pointX_arg, const double pointY_arg, const double pointZ_arg) const;
        # /** \brief Check if voxel at given point from input cloud exist.
        #  * \param[in] pointIdx_arg point to be checked
        #  * \return "true" if voxel exist; "false" otherwise
        #  */
        # bool isVoxelOccupiedAtPoint (const int& pointIdx_arg) const;
        # /** \brief Get a PointT vector of centers of all occupied voxels.
        #  * \param[out] voxelCenterList_arg results are written to this vector of PointT elements
        #  * \return number of occupied voxels
        #  */
        # int getOccupiedVoxelCenters (AlignedPointTVector &voxelCenterList_arg) const;
        # /** \brief Get a PointT vector of centers of voxels intersected by a line segment.
        #  * This returns a approximation of the actual intersected voxels by walking
        #  * along the line with small steps. Voxels are ordered, from closest to
        #  * furthest w.r.t. the origin.
        #  * \param[in] origin origin of the line segment
        #  * \param[in] end end of the line segment
        #  * \param[out] voxel_center_list results are written to this vector of PointT elements
        #  * \param[in] precision determines the size of the steps: step_size = octree_resolution x precision
        #  * \return number of intersected voxels
        #  */
        # int getApproxIntersectedVoxelCentersBySegment (
        #     const Eigen::Vector3f& origin, const Eigen::Vector3f& end,
        #     AlignedPointTVector &voxel_center_list, float precision = 0.2);
        # /** \brief Delete leaf node / voxel at given point
        #  * \param[in] point_arg point addressing the voxel to be deleted.
        # void deleteVoxelAtPoint (const PointT& point_arg);
        # /** \brief Delete leaf node / voxel at given point from input cloud
        #  *  \param[in] pointIdx_arg index of point addressing the voxel to be deleted.
        #  */
        # void deleteVoxelAtPoint (const int& pointIdx_arg);
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Bounding box methods
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Investigate dimensions of pointcloud data set and define corresponding bounding box for octree. */
        # void defineBoundingBox ();
        # /** \brief Define bounding box for octree
        #  * \note Bounding box cannot be changed once the octree contains elements.
        #  * \param[in] minX_arg X coordinate of lower bounding box corner
        #  * \param[in] minY_arg Y coordinate of lower bounding box corner
        #  * \param[in] minZ_arg Z coordinate of lower bounding box corner
        #  * \param[in] maxX_arg X coordinate of upper bounding box corner
        #  * \param[in] maxY_arg Y coordinate of upper bounding box corner
        #  * \param[in] maxZ_arg Z coordinate of upper bounding box corner
        # void defineBoundingBox (const double minX_arg, const double minY_arg,
        #       const double minZ_arg, const double maxX_arg, const double maxY_arg,
        #       const double maxZ_arg);
        # /** \brief Define bounding box for octree
        #  * \note Lower bounding box point is set to (0, 0, 0)
        #  * \note Bounding box cannot be changed once the octree contains elements.
        #  * \param[in] maxX_arg X coordinate of upper bounding box corner
        #  * \param[in] maxY_arg Y coordinate of upper bounding box corner
        #  * \param[in] maxZ_arg Z coordinate of upper bounding box corner
        # void defineBoundingBox (const double maxX_arg, const double maxY_arg,
        #     const double maxZ_arg);
        # /** \brief Define bounding box cube for octree
        #  * \note Lower bounding box corner is set to (0, 0, 0)
        #  * \note Bounding box cannot be changed once the octree contains elements.
        #  * \param[in] cubeLen_arg side length of bounding box cube.
        #  */
        # void defineBoundingBox (const double cubeLen_arg);
        # /** \brief Get bounding box for octree
        #  * \note Bounding box cannot be changed once the octree contains elements.
        #  * \param[in] minX_arg X coordinate of lower bounding box corner
        #  * \param[in] minY_arg Y coordinate of lower bounding box corner
        #  * \param[in] minZ_arg Z coordinate of lower bounding box corner
        #  * \param[in] maxX_arg X coordinate of upper bounding box corner
        #  * \param[in] maxY_arg Y coordinate of upper bounding box corner
        #  * \param[in] maxZ_arg Z coordinate of upper bounding box corner
        # void getBoundingBox (double& minX_arg, double& minY_arg, double& minZ_arg,
        #     double& maxX_arg, double& maxY_arg, double& maxZ_arg) const;
        # /** \brief Calculates the squared diameter of a voxel at given tree depth
        #  * \param[in] treeDepth_arg depth/level in octree
        #  * \return squared diameter
        # double getVoxelSquaredDiameter (unsigned int treeDepth_arg) const;
        # /** \brief Calculates the squared diameter of a voxel at leaf depth
        #  * \return squared diameter
        #  */
        # inline double getVoxelSquaredDiameter () const
        # /** \brief Calculates the squared voxel cube side length at given tree depth
        #  * \param[in] treeDepth_arg depth/level in octree
        #  * \return squared voxel cube side length
        # double getVoxelSquaredSideLen (unsigned int treeDepth_arg) const;
        # /** \brief Calculates the squared voxel cube side length at leaf level
        #  * \return squared voxel cube side length
        # inline double getVoxelSquaredSideLen () const
        # /** \brief Generate bounds of the current voxel of an octree iterator
        #  * \param[in] iterator: octree iterator
        #  * \param[out] min_pt lower bound of voxel
        #  * \param[out] max_pt upper bound of voxel
        # inline void getVoxelBounds (OctreeIteratorBase<int, OctreeT>& iterator, Eigen::Vector3f &min_pt, Eigen::Vector3f &max_pt)
        # protected:
        # /** \brief Add point at index from input pointcloud dataset to octree
        #  * \param[in] pointIdx_arg the index representing the point in the dataset given by \a setInputCloud to be added
        #  */
        # void addPointIdx (const int pointIdx_arg)
        # /** \brief Get point at index from input pointcloud dataset
        #  * \param[in] index_arg index representing the point in the dataset given by \a setInputCloud
        #  * \return PointT from input pointcloud dataset
        # const PointT& getPointByIndex (const unsigned int index_arg) const
        # /** \brief Find octree leaf node at a given point
        #  * \param[in] point_arg query point
        #  * \return pointer to leaf node. If leaf node does not exist, pointer is 0.
        # LeafT* findLeafAtPoint (const PointT& point_arg) const;
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # // Protected octree methods based on octree keys
        # //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        # /** \brief Define octree key setting and octree depth based on defined bounding box. */
        # void getKeyBitSize ();
        # /** \brief Grow the bounding box/octree until point fits
        #  * \param[in] pointIdx_arg point that should be within bounding box;
        # void adoptBoundingBoxToPoint (const PointT& pointIdx_arg);
        # /** \brief Checks if given point is within the bounding box of the octree
        #  * \param[in] pointIdx_arg point to be checked for bounding box violations
        #  * \return "true" - no bound violation
        # inline bool isPointWithinBoundingBox (const PointT& pointIdx_arg) const
        # /** \brief Generate octree key for voxel at a given point
        #  * \param[in] point_arg the point addressing a voxel
        #  * \param[out] key_arg write octree key to this reference
        # void genOctreeKeyforPoint (const PointT & point_arg, OctreeKey &key_arg) const;
        # /** \brief Generate octree key for voxel at a given point
        #  * \param[in] pointX_arg X coordinate of point addressing a voxel
        #  * \param[in] pointY_arg Y coordinate of point addressing a voxel
        #  * \param[in] pointZ_arg Z coordinate of point addressing a voxel
        #  * \param[out] key_arg write octree key to this reference
        # void genOctreeKeyforPoint (const double pointX_arg, const double pointY_arg, const double pointZ_arg, OctreeKey & key_arg) const;
        # /** \brief Virtual method for generating octree key for a given point index.
        #  * \note This method enables to assign indices to leaf nodes during octree deserialization.
        #  * \param[in] data_arg index value representing a point in the dataset given by \a setInputCloud
        #  * \param[out] key_arg write octree key to this reference
        #  * \return "true" - octree keys are assignable
        # virtual bool genOctreeKeyForDataT (const int& data_arg, OctreeKey & key_arg) const;
        # /** \brief Generate a point at center of leaf node voxel
        #  * \param[in] key_arg octree key addressing a leaf node.
        #  * \param[out] point_arg write leaf node voxel center to this point reference
        # void genLeafNodeCenterFromOctreeKey (const OctreeKey & key_arg, PointT& point_arg) const;
        # /** \brief Generate a point at center of octree voxel at given tree level
        #  * \param[in] key_arg octree key addressing an octree node.
        #  * \param[in] treeDepth_arg octree depth of query voxel
        #  * \param[out] point_arg write leaf node center point to this reference
        # void genVoxelCenterFromOctreeKey (const OctreeKey & key_arg, unsigned int treeDepth_arg, PointT& point_arg) const;
        # /** \brief Generate bounds of an octree voxel using octree key and tree depth arguments
        #  * \param[in] key_arg octree key addressing an octree node.
        #  * \param[in] treeDepth_arg octree depth of query voxel
        #  * \param[out] min_pt lower bound of voxel
        #  * \param[out] max_pt upper bound of voxel
        # void genVoxelBoundsFromOctreeKey (const OctreeKey & key_arg,
        #     unsigned int treeDepth_arg, Eigen::Vector3f &min_pt,
        #     Eigen::Vector3f &max_pt) const;
        # /** \brief Recursively search the tree for all leaf nodes and return a vector of voxel centers.
        #  * \param[in] node_arg current octree node to be explored
        #  * \param[in] key_arg octree key addressing a leaf node.
        #  * \param[out] voxelCenterList_arg results are written to this vector of PointT elements
        #  * \return number of voxels found
        # int getOccupiedVoxelCentersRecursive (const BranchNode* node_arg,
        #     const OctreeKey& key_arg,
        #     AlignedPointTVector &voxelCenterList_arg) const;
###

# Version 1.7.2, 1.8.0 NG
# # namespace pcl
# # namespace octree
# # template<typename PointT, typename LeafT = OctreeContainerDataTVector<int>,
# # typename BranchT = OctreeContainerEmpty<int> >
# #     class OctreePointCloudChangeDetector : public OctreePointCloud<PointT, LeafT, BranchT, Octree2BufBase<int, LeafT, BranchT> >
# cdef extern from "pcl/octree/octree_pointcloud_changedetector.h" namespace "pcl::octree":
#     cdef cppclass OctreePointCloudChangeDetector[T](OctreePointCloud[T]):
# #     cdef cppclass OctreePointCloudChangeDetector[T, LeafT, BranchT](OctreePointCloud[T, LeafT, BranchT]):
#         OctreePointCloudChangeDetector (const double resolution_arg)
#         #  public:
#         #/** \brief Get a indices from all leaf nodes that did not exist in previous buffer.
#         # * \param indicesVector_arg: results are written to this vector of int indices
#         # * \param minPointsPerLeaf_arg: minimum amount of points required within leaf node to become serialized.
#         # * \return number of point indices
#         #int getPointIndicesFromNewVoxels (std::vector<int> &indicesVector_arg, const int minPointsPerLeaf_arg = 0)
# 
# ctypedef OctreePointCloudChangeDetector[cpp.PointXYZ] OctreePointCloudChangeDetector_t
# ctypedef OctreePointCloudChangeDetector[cpp.PointXYZI] OctreePointCloudChangeDetector_PointXYZI_t
# ctypedef OctreePointCloudChangeDetector[cpp.PointXYZRGB] OctreePointCloudChangeDetector_PointXYZRGB_t
# ctypedef OctreePointCloudChangeDetector[cpp.PointXYZRGBA] OctreePointCloudChangeDetector_PointXYZRGBA_t
###

# octree_pointcloud_density.h
# namespace pcl
# namespace octree
# template<typename DataT>
# class OctreePointCloudDensityContainer
# cdef extern from "pcl/octree/octree_pointcloud_density.h" namespace "pcl::octree":
#     cdef cppclass OctreePointCloudDensityContainer[T]:
#         OctreePointCloudDensityContainer ()
#         # /** \brief deep copy function */
#         # virtual OctreePointCloudDensityContainer * deepCopy () const
#         # /** \brief Get size of container (number of DataT objects)
#         #  * \return number of DataT elements in leaf node container.
#         # size_t getSize () const
#         # /** \brief Read input data. Only an internal counter is increased.
#         # void setData (const DataT&)
#         # /** \brief Returns a null pointer as this leaf node does not store any data.
#         #   * \param[out] data_arg: reference to return pointer of leaf node DataT element (will be set to 0).
#         # void getData (const DataT*& data_arg) const
#         # /** \brief Empty getData data vector implementation as this leaf node does not store any data. \
#         # void getData (std::vector<DataT>&) const
#         # /** \brief Return point counter.
#         #   * \return Amaount of points
#         # unsigned int getPointCounter ()
#         # /** \brief Empty reset leaf node implementation as this leaf node does not store any data. */
#         # void reset ()
###

# template<typename PointT, typename LeafT = OctreePointCloudDensityContainer<int> , typename BranchT = OctreeContainerEmpty<int> >
# class OctreePointCloudDensity : public OctreePointCloud<PointT, LeafT, BranchT>
# cdef extern from "pcl/octree/octree_pointcloud_density.h" namespace "pcl::octree":
#     cdef cppclass OctreePointCloudDensity[T, LeafT, BranchT](OctreePointCloud[T, LeafT, BranchT]):
#         OctreePointCloudDensity (const double resolution_arg)
#         # /** \brief Get the amount of points within a leaf node voxel which is addressed by a point
#         #   * \param[in] point_arg: a point addressing a voxel
#         #   * \return amount of points that fall within leaf node voxel
#         #   */
#         # unsigned int getVoxelDensityAtPoint (const PointT& point_arg) const
###

# octree_pointcloud_occupancy.h
###
# octree_pointcloud_pointvector.h
###
# octree_pointcloud_singlepoint.h
###
# octree_pointcloud_voxelcentroid.h
###

# octree_search.h
cdef extern from "pcl/octree/octree_search.h" namespace "pcl::octree":
    cdef cppclass OctreePointCloudSearch[T](OctreePointCloud[T]):
        OctreePointCloudSearch(double)
        int radiusSearch (cpp.PointXYZ, double, vector[int], vector[float], unsigned int)
        int radiusSearch (cpp.PointXYZI, double, vector[int], vector[float], unsigned int)
        int radiusSearch (cpp.PointXYZRGB, double, vector[int], vector[float], unsigned int)
        int radiusSearch (cpp.PointXYZRGBA, double, vector[int], vector[float], unsigned int)
        # Add index(inline?)
        int radiusSearch (cpp.PointCloud[T], int, double, vector[int], vector[float], unsigned int)
        # inline define
        # int nearestKSearch (cpp.PointCloud[T], int, int, vector[int], vector[float])
        int nearestKSearch (cpp.PointCloud[T], int, int, vector[int], vector[float])
        # int nearestKSearch (const PointT &point, int k, std::vector<int> &k_indices, std::vector<float> &k_sqr_distances) const;

ctypedef OctreePointCloudSearch[cpp.PointXYZ] OctreePointCloudSearch_t
ctypedef OctreePointCloudSearch[cpp.PointXYZI] OctreePointCloudSearch_PointXYZI_t
ctypedef OctreePointCloudSearch[cpp.PointXYZRGB] OctreePointCloudSearch_PointXYZRGB_t
ctypedef OctreePointCloudSearch[cpp.PointXYZRGBA] OctreePointCloudSearch_PointXYZRGBA_t

###

###############################################################################
# Enum
###############################################################################

###############################################################################
# Activation
###############################################################################
