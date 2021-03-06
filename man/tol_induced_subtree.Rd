% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/tol.R
\name{tol_induced_subtree}
\alias{tol_induced_subtree}
\title{Subtree from the Open Tree of Life}
\usage{
tol_induced_subtree(ott_ids = NULL, file, ...)
}
\arguments{
\item{ott_ids}{OTT ids indicating nodes to be used as tips in the
induced tree}

\item{file}{if specified, the function will write the subtree to a
file in newick format.}

\item{...}{additional arguments to customize the API call (see
\code{\link{rotl}} for more information).}
}
\value{
If no value is specified to the \code{file} argument
    (default), a phyogenetic tree of class \code{phylo}.

    Otherwise, the function returns invisibly a logical indicating
    whether the file was successfully created.
}
\description{
Extract a subtree based on a vector of ott ids.
}
\details{
Return a tree with tips corresponding to the nodes identified in
the input set that is consistent with the topology of the current
synthetic tree. This tree is equivalent to the minimal subtree
induced on the draft tree by the set of identified nodes. Ott ids
that do not correspond to any nodes found in the graph, or which
are in the graph but are absent from the synthetic tree, will be
identified in the output (but obvisouly will be absent from the
resulting induced tree). Branch lengths in the result may be
arbitrary, and the tip labels of the tree may either be taxonomic
names or (for nodes not corresponding directly to named taxa) node
ids.
}
\examples{
\dontrun{
res <- tol_induced_subtree(ott_ids=c(292466, 501678, 267845, 666104, 316878, 102710, 176458))
tree_file <- tempfile(fileext=".tre")
tol_induced_subtree(ott_ids=c(292466, 501678, 267845, 666104, 316878, 102710, 176458),
                    file=tree_file)
}
}

