locals {
    info_tags = "${merge({"Environment": "${var.logical_environment}"}, var.generic_tags, {"Branch": "${var.git_branch}"})}"
}