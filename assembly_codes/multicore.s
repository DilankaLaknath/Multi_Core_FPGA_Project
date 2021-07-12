// A*B = C matrix multiplication
RSTALL   // ID <- Core ID (0,1,2,3,4,..)

LDAC noc   //AC <- M[noc] = No of cores
MVIDR     //R <- ID
INCR       // R<-R+1 (CID+1)                        NOC=1
COMP       // if AC < R, z =1, else z=0
JMPZ mend

RSTI        // I<-ID
RSTJ        //J <- 0

loop:
    MVIR            //R <- I
    LDAC n          //no.of rows in A = no.of rows in C
    INCR
    COMP            //if AC<R z=1, else z=0
    //SUB            // AC <- AC - R , if AC ==0 then z=1 else z=0
    JMPZ mend       // JUMP if z=1
    RSTK            //K <-- 0

    loop1:
        MVKR       //R <- K
        LDAC p     //no.of columns in B = no.of columns in C
        INCR
        COMP
        //SUB        //AC <- AC - R, if AC ==0 then z=1 else z=0
        JMPZ mend1  // JUMP if z=1
        RSTSUM      //SUM <- 0
        JUMP loop2

        mstore:
            MVIR    //R <- I
            LDAC p  //
            MULR    // AC <- AC*R
            MVKR    // R <-K
            ADDR    // AC <-- AC+R
            MVACR   //R <-AC
            //LDAC s  //AC <- s  (s-size of one element in C matrix in bytes)
            //MULR    // AC <- AC*R
            //MVACR   //R <- AC
            LDAC cp //AC <-M[cp] (addr of first element of C matrix)
            ADDR    // AC <- AC+R
            MVACR   // R <- AC

            MVSUMAC     // AC<-SUM
            STAC        // M[R] <- AC

            INCK        // K<-K+1
            RSTJ
            JUMP loop1

        loop2:
            MVJR       //R<-J
            LDAC m     //no.of columns in A = no.of rows in B
            INCR
            COMP
            //SUB       //AC<-AC-R
            JMPZ mstore

            MVIR
            LDAC m
            MULR        //AC<-AC*R(i*m)
            MVJR        //R<-J
            ADDR        //AC<-AC+R
            MVACR       //R<-AC
            LDAC ap     //AC <- M[ap] (addr of first element of A matrix)
            ADDR       //AC<-AC+R (AC+AP)
            MVACR       //R <-AC
            LOADAC R    //AC <- M[R]
            MVACA       //A<-AC

            MVJR        //R<-J
            LDAC p      //AC<-M[p]
            MULR        //AC<-AC*R
            MVKR        //R<-K
            ADDR        //AC<-AC+R
            MVACR       //R<-AC
            LDAC bp     //AC<-M[bp]
            ADDR       //AC<-AC+R (AC+BP)
            MVACR
            LOADAC R

            MULA        //AC<-AC*A
            ADDSUM      //AC<-AC+SUM
            MVACSUM     //SUM <- AC

            INCJ        //J<-J+1
            JUMP loop2

    mend1:
        MVIR        //R<-I
        LDAC noc
        ADDR
        MVACI
        //INCI        //I<-I+1
        JUMP loop

mend:
    ENDOP

