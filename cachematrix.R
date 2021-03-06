## Define makeCacheMatrix() function
##
## makeCacheMatrix() function accepts one argument: x, a matrix
## makeCacheMatrix() function returns a list of four function objects
makeCacheMatrix <- function(x = matrix()) {
    
    ## Initialize matinv to NULL in function environment
    matinv <- NULL
    
    ## Define set() function
    ##
    ## set() function accepts one argument: y, a matrix
    ## set() function uses superassignment to set x object in parent environment to value of y
    ##       and matinv object in parent environment to NULL value
    set <- function(y) {
        x <<- y
        matinv <<- NULL
    }
    
    ## Define get() function
    ##
    ## get() function accepts no arguments
    ## get() function returns value of free variable x
    get <- function() x
    
    ## Define setinv() function
    ##
    ## setinv() function accepts one argument: inv, a matrix
    ## setinv() function uses superassignment to set matinv object in parent environment to value of inv
    setinv <- function(inv) matinv <<- inv
    
    ## Define getinv() function
    ##
    ## getinv() function accepts no arguments
    ## getinv() function returns value of free variable matinv
    getinv <- function() matinv
    
    ## makeCacheMatrix() function returns list of four function objects: 
    ##  1. set(), 
    ##  2. get(), 
    ##  3. setinv(), and
    ##  4. getinv()
    
    list(set = set,
         get = get,
         setinv = setinv,
         getinv = getinv)
    
}


## cacheSolve() function calculates the inverse of an input matrix.
##
## cacheSolve() accepts one input parameter: x, a list created with the makeCacheMatrix() function.
## cacheSolve() returns the inverse matrix from memory, if it has been evaluated previously, or
##              calculates the inverse matrix and stores the result to memory for future reference.

cacheSolve <- function(x, ...) {
    
    ## Assigns return value of getinv() function in input list x to matinv object in local environment
    matinv <- x$getinv()
    
    ## If a cached value existed and was retrieved successfully, print note to log and quit function,
    ## returning the value of matinv, the cached matrix inverse.
    if(!is.null(matinv)) {
        message("getting cached data")
        return(matinv)
    }
    
    ## Otherwise, no cached value existed.
    ## Assign the matrix object returned by the get() function in input list x to matrix data
    data <- x$get()
    
    ## Calculate the inverse of the matrix data
    matinv <- solve(data, ...)
    
    ## Store and return the matrix inverse
    x$setinv(matinv)
    matinv
    
}