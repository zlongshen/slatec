*DECK CDQAWF
      SUBROUTINE CDQAWF (LUN, KPRINT, IPASS)
C***BEGIN PROLOGUE  CDQAWF
C***PURPOSE  Quick check for DQAWF.
C***LIBRARY   SLATEC
C***TYPE      DOUBLE PRECISION (CQAWF-S, CDQAWF-D)
C***AUTHOR  (UNKNOWN)
C***ROUTINES CALLED  D1MACH, DF0F, DF1F, DPRIN, DQAWF
C***REVISION HISTORY  (YYMMDD)
C   ??????  DATE WRITTEN
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   901205  Added PASS/FAIL message and changed the name of the first
C           argument.  (RWC)
C   910501  Added PURPOSE and TYPE records.  (WRB)
C***END PROLOGUE  CDQAWF
C
C FOR FURTHER DOCUMENTATION SEE ROUTINE CQPDOC
C
      DOUBLE PRECISION A,ABSERR,D1MACH,EPSABS,EPMACH,
     *  ERROR,EXACT0,DF0F,DF1F,OMEGA,PI,RESULT,UFLOW,WORK
      INTEGER IER,IP,IPASS,KPRINT,LENW,LIMIT,LIMLST,LST,NEVAL
      DIMENSION IERV(4),IWORK(450),WORK(1425)
      EXTERNAL DF0F,DF1F
      DATA EXACT0/0.1422552162575912D+01/
      DATA PI/0.31415926535897932D+01/
C***FIRST EXECUTABLE STATEMENT  CDQAWF
      IF (KPRINT.GE.2) WRITE (LUN, '(''1DQAWF QUICK CHECK''/)')
C
C TEST ON IER = 0
C
      IPASS = 1
      MAXP1 = 21
      LIMLST = 50
      LIMIT = 200
      LENIW = LIMIT*2+LIMLST
      LENW = LENIW*2+MAXP1*25
      EPMACH = D1MACH(4)
      EPSABS = MAX(SQRT(EPMACH),0.1D-02)
      A = 0.0D+00
      OMEGA = 0.8D+01
      INTEGR = 2
      CALL DQAWF(DF0F,A,OMEGA,INTEGR,EPSABS,RESULT,ABSERR,NEVAL,
     *  IER,LIMLST,LST,LENIW,MAXP1,LENW,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      ERROR = ABS(EXACT0-RESULT)
      IF(IER.EQ.0.AND.ERROR.LE.ABSERR.AND.ABSERR.LE.EPSABS)
     *  IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,0,KPRINT,IP,EXACT0,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 1
C
      LIMLST = 3
      LENIW = 403
      LENW = LENIW*2+MAXP1*25
      CALL DQAWF(DF0F,A,OMEGA,INTEGR,EPSABS,RESULT,ABSERR,NEVAL,
     *  IER,LIMLST,LST,LENIW,MAXP1,LENW,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.1) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,1,KPRINT,IP,EXACT0,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 3 OR 4 OR 1 OR 2
C
      LIMLST = 50
      LENIW = LIMIT*2+LIMLST
      LENW = LENIW*2+MAXP1*25
      UFLOW = D1MACH(1)
      CALL DQAWF(DF1F,A,0.0D+00,1,UFLOW,RESULT,ABSERR,NEVAL,
     *  IER,LIMLST,LST,LENIW,MAXP1,LENW,IWORK,WORK)
      IERV(1) = IER
      IERV(2) = 4
      IERV(3) = 1
      IERV(4) = 2
      IP = 0
      IF(IER.EQ.3.OR.IER.EQ.4.OR.IER.EQ.1.OR.IER.EQ.2) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,3,KPRINT,IP,PI,RESULT,ABSERR,NEVAL,IERV,4)
C
C TEST ON IER = 6
C
      LIMLST = 50
      LENIW = 20
      CALL DQAWF(DF0F,A,OMEGA,INTEGR,EPSABS,RESULT,ABSERR,NEVAL,
     *  IER,LIMLST,LST,LENIW,MAXP1,LENW,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.6) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,6,KPRINT,IP,EXACT0,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 7
C
      LIMLST = 50
      LENIW = 52
      LENW = LENIW*2+MAXP1*25
      CALL DQAWF(DF0F,A,OMEGA,INTEGR,EPSABS,RESULT,ABSERR,NEVAL,
     *  IER,LIMLST,LST,LENIW,MAXP1,LENW,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.7) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL DPRIN(LUN,7,KPRINT,IP,EXACT0,RESULT,ABSERR,NEVAL,IERV,1)
C
      IF (KPRINT.GE.1) THEN
         IF (IPASS.EQ.0) THEN
            WRITE(LUN, '(/'' SOME TEST(S) IN CDQAWF FAILED''/)')
         ELSEIF (KPRINT.GE.2) THEN
            WRITE(LUN, '(/'' ALL TEST(S) IN CDQAWF PASSED''/)')
         ENDIF
      ENDIF
      RETURN
      END
