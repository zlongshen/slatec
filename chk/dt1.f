*DECK DT1
      DOUBLE PRECISION FUNCTION DT1 (X)
C***BEGIN PROLOGUE  DT1
C***PURPOSE  Subsidiary to
C***LIBRARY   SLATEC
C***AUTHOR  (UNKNOWN)
C***ROUTINES CALLED  DF1S
C***REVISION HISTORY  (YYMMDD)
C   ??????  DATE WRITTEN
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C***END PROLOGUE  DT1
      DOUBLE PRECISION A,B,DF1S,X,X1,Y
C***FIRST EXECUTABLE STATEMENT  DT1
      A = 0.0D+00
      B = 0.1D+01
      X1 = X+0.1D+01
      Y = (B-A)/X1+A
      DT1 = (B-A)*DF1S(Y)/X1/X1
      RETURN
      END
