/*!
 *  Copyright (c) 2016 by Contributors
 * \file broadcast_reduce_op.cu
 * \brief GPU Implementation of broadcast and reduce functions.
 */
#include "./broadcast_reduce_op.h"

namespace mxnet {
namespace op {
NNVM_REGISTER_OP(sum)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesCompute<gpu, mshadow::red::sum>);

NNVM_REGISTER_OP(_backward_sum)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesBackwardUseNone<gpu>);

NNVM_REGISTER_OP(max)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesCompute<gpu, mshadow::red::maximum>);

NNVM_REGISTER_OP(_backward_max)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesBackwardUseInOut<gpu, mshadow_op::eq>);

NNVM_REGISTER_OP(min)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesCompute<gpu, mshadow::red::minimum>);

NNVM_REGISTER_OP(_backward_min)
.set_attr<FCompute>("FCompute<gpu>", ReduceAxesBackwardUseInOut<gpu, mshadow_op::eq>);

NNVM_REGISTER_OP(broadcast_axis)
.set_attr<FCompute>("FCompute<gpu>", BroadcastCompute<gpu>);

NNVM_REGISTER_OP(broadcast_to)
.set_attr<FCompute>("FCompute<gpu>", BroadcastCompute<gpu>);

}  // namespace op
}  // namespace mxnet