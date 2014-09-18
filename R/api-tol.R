## Summary information about the OpenTree Tree of Life
.tol_about <- function(study_list=FALSE) {
    if (!is.logical(study_list)) {
        stop("Argument \'study_list\' should be logical")
    }
    q <- list(study_list=jsonlite::unbox(study_list))
    res <- otl_POST(path="tree_of_life/about", body=q)
    cont <- httr::content(res)
    return(invisible(cont))
}


## Get the MRCA of a set of nodes
.tol_mrca <- function(ott_ids=NULL, node_ids=NULL) {
    if (!is.null(node_ids) && !is.null(ott_ids)) {
        stop("Use only node_id OR ott_id")
    }
    if (is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids = ott_ids)
    if (!is.null(node_ids) && is.null(ott_ids)) q <- list(node_ids = node_ids)
    if (!is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids = ott_ids,
                                                           node_ids = node_ids)
    res <- otl_POST(path="tree_of_life/mrca", body=q)
    cont <- httr::content(res)
    return(cont)
}


## Get a subtree from the OpenTree Tree of Life
.tol_subtree <- function(node_id=NULL, ott_id=NULL, tree_id=NULL) {
    if (!is.null(node_id) && !is.null(ott_id)) {
        stop("Use only node_id OR ott_id")
    }
    if (is.null(node_id) && is.null(ott_id)) {
        stop("Must supply a \'node_id\' OR \'ott_id\'")
    }
    if (!is.null(tree_id)) {
        stop("\'tree_id\' is currently ignored")
    }
    if (is.null(node_id) && !is.null(ott_id)) {
        q <- list(ott_id = jsonlite::unbox(ott_id))
    }
    if (!is.null(node_id) && is.null(ott_id)) {
        q <- list(node_id = jsonlite::unbox(node_id))
    }
    res <- otl_POST(path="tree_of_life/subtree", body=q)
    cont <- httr::content(res)
    return(cont)
}


## Get an induced subtree from the OpenTree Tree of Life from a set of nodes
.tol_induced_subtree <- function(node_ids=NULL, ott_ids=NULL) {
    if (is.null(node_ids) && is.null(ott_ids)) {
        stop("Must supply \'node_ids\' and/or \'ott_ids\'")
    }
    if ((!is.null(node_ids) && any(is.na(node_ids))) ||
        (!is.null(node_ids) && any(is.na(ott_ids)))) {
        stop("NA are not allowed")
    }
    if (is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids  = ott_ids)
    if (!is.null(node_ids) && is.null(ott_ids)) q <- list(node_ids = node_ids)
    if (!is.null(node_ids) && !is.null(ott_ids)) q <- list(ott_ids = ott_ids,
                                                           node_ids = node_ids)
    res <- otl_POST("tree_of_life/induced_subtree", body=q)
    cont <- httr::content(res)
    return(cont)
}