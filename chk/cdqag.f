*DECK CDQAG
      SUBROUTINE CDQAG (LUN, KPRINT, IPASS)
C***BEGIN PROLOGUE  CDQAG
C***PURPOSE  Quick check for DQAG.
C***LIBRARY   SLATEC
C***TYPE      DOUBLE PRECISION (CQAG-S, CDQAG-D)
C***AUTHOR  (UNKNOWN)
C***ROUTINES CALLED  D1MACH, DF1G, DF2G, DF3G, DPRIN, DQAG
C***REVISION HISTORY  (YYMMDD)
C   ??????  DATE WRITTEN
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   901205  Added PASS/FAIL message and changed the name of the first
C           argument.  (RWC)
C   910501  Added PURPOSE and TYPE records.  (WRB)
C***END PROLOGUE  CDQAG
C
C FOR FURTHER DOCUMENTATION SEE ROUTINE CQPDOC
C
      DOUBLE PRECISION A,ABSERR,B,D1MACH,EPMACH,EPSABS,EPSREL,ERROR,
     *EXACT1,EXACT2,EXACT3,DF1G,DF2G,DF3G,PI,RESULT,UFLOW,WORK
      INTEGER IER,IP,IPASS,IWORK,KEY,KPRINT,LAST,LENW,LIMIT,
     *  NEVAL
      DIMENSION IERV(2),IWORK(100),WORK(400)
      EXTERNAL DF1G,DF2G,DF3G
      DATA PI/0.31415926535897932D+01/
      DATA EXACT1/0.1154700538379252D+01/
      DATA EXACT2/0.11780972450996172D+00/
      DATA EXACT3/0.1855802D+02/
C***FIRST EXECUTABLE STATEMENT  CDQAG
      IF (KPRINT.GE.2) WRITE (LUN, '(''1DQAG QUICK CHECK''/)')
C
C TEST ON IER = 0
C
      IPASS = 1
      LIMIT = 100
      LENW = LIMIT*4
      EPSABS = 0.0D+00
      EPMACH = D1MACH(4)
      KEY = 6
      EPSREL = MAX(SQRT(EPMACH),0.1D-07)
      A = 0.0D+00
      B = 0.1D+01
      CALL DQAG(DF1G,A,B,EPSABS,EPSREL,KEY,RESULT,ABSERR,NEVAL,IER,
     *LIMIT,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      ERROR = ABS(EXACT1-RESULT)
      IF(IER.EQ.0.AND.ERROR.LE.ABSERR.AND.ABSERR.LE.EPSREL*ABS(EXACT1))
     *   IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,0,KPRINT,IP,EXACT1,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 1
C
      LIMIT = 1
      LENW = LIMIT*4
      B = PI*0.2D+01
       CALL DQAG(DF2G,A,B,EPSABS,EPSREL,KEY,RESULT,ABSERR,NEVAL,IER,
     *  LIMIT,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.1) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,1,KPRINT,IP,EXACT2,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 2 OR 1
C
      UFLOW = D1MACH(1)
      LIMIT = 100
      LENW = LIMIT*4
      CALL DQAG(DF2G,A,B,UFLOW,0.0D+00,KEY,RESULT,ABSERR,NEVAL,IER,
     *  LIMIT,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IERV(2) = 1
      IP = 0
      IF(IER.EQ.2.OR.IER.EQ.1) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,2,KPRINT,IP,EXACT2,RESULT,ABSERR,NEVAL,IERV,2)
C
C TEST ON IER = 3 OR 1
C
      B = 0.1D+01
      CALL DQAG(DF3G,A,B,EPSABS,EPSREL,1,RESULT,ABSERR,NEVAL,IER,
     *  LIMIT,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IERV(2) = 1
      IP = 0
      IF(IER.EQ.3.OR.IER.EQ.1) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,3,KPRINT,IP,EXACT3,RESULT,ABSERR,NEVAL,IERV,2)
C
C TEST ON IER = 6
C
      LENW = 1
      CALL DQAG(DF1G,A,B,EPSABS,EPSREL,KEY,RESULT,ABSERR,NEVAL,IER,
     *  LIMIT,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.6.AND.RESULT.EQ.0.0D+00.AND.ABSERR.EQ.0.0D+00.AND.
     *  NEVAL.EQ.0.AND.LAST.EQ.0) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,6,KPRINT,IP,EXACT1,RESULT,ABSERR,NEVAL,IERV,1)
C
      IF (KPRINT.GE.1) THEN
         IF (IPASS.EQ.0) THEN
            WRITE(LUN, '(/'' SOME TEST(S) IN CDQAG FAILED''/)')
         ELSEIF (KPRINT.GE.2) THEN
            WRITE(LUN, '(/'' ALL TEST(S) IN CDQAG PASSED''/)')
         ENDIF
      ENDIF
      RETURN
      END
