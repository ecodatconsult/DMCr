#' Baut eine Verbindung zur FVA-Fotofallendatenbank auf (PostgreSQL).
#'
#'
#' @type character, deprecated
#' @return Formal class PostgreSQLConnection
#' @export
#'
#' @examples
#'
dbConnection <- function(type){

  require(RPostgreSQL)
  require(DBI)

  con <- with(read.csv(system.file("db_login.csv", package = "DMCr")), {
    dbConnect("PostgreSQL"
                     , user = user
                     , password = pw
                     , host = host
                     , port = port
                     , dbname = db)
  })

  if(exists("con")){
    assign("con",con, envir = .GlobalEnv)
  }else{
    #stop("Verbindung zur Datenbank konnte nicht hergesellt werden", call. = TRUE, domain = NULL)
  }

}
