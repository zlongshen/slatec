*DECK CQAGP
      SUBROUTINE CQAGP (LUN, KPRINT, IPASS)
C***BEGIN PROLOGUE  CQAGP
C***PURPOSE  Quick check for QAGP.
C***LIBRARY   SLATEC
C***TYPE      SINGLE PRECISION (CQAGP-S, CDQAGP-D)
C***AUTHOR  (UNKNOWN)
C***ROUTINES CALLED  CPRIN, F1P, F2P, F3P, F4P, QAGP, R1MACH
C***REVISION HISTORY  (YYMMDD)
C   ??????  DATE WRITTEN
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   901205  Added PASS/FAIL message and changed the name of the first
C           argument.  (RWC)
C   910501  Added PURPOSE and TYPE records.  (WRB)
C***END PROLOGUE  CQAGP
C
C FOR FURTHER DOCUMENTATION SEE ROUTINE CQPDOC
C
      REAL A,ABSERR,B,R1MACH,EPMACH,EPSABS,EPSREL,ERROR,EXACT1,
     *  EXACT2,EXACT3,F1P,F2P,F3P,F4P,OFLOW,POINTS,P1,P2,RESULT,
     *  UFLOW,WORK
      INTEGER IER,IP,IPASS,IWORK,KPRINT,LAST,LENIW,LENW,LIMIT,LUN,
     *  NEVAL,NPTS2
      DIMENSION IERV(4),IWORK(205),POINTS(5),WORK(405)
      EXTERNAL F1P,F2P,F3P,F4P
      DATA EXACT1/0.4285277667368085E+01/
      DATA EXACT2/0.909864525656E-2/
      DATA EXACT3/0.31415926535897932E+01/
      DATA P1/0.1428571428571428E+00/
      DATA P2/0.6666666666666667E+00/
C***FIRST EXECUTABLE STATEMENT  CQAGP
      IF (KPRINT.GE.2) WRITE (LUN, '(''1QAGP QUICK CHECK''/)')
C
C TEST ON IER = 0
C
      IPASS = 1
      NPTS2 = 4
      LIMIT = 100
      LENIW = LIMIT*2+NPTS2
      LENW = LIMIT*4+NPTS2
      EPSABS = 0.0E+00
      EPMACH = R1MACH(4)
      EPSREL = MAX(SQRT(EPMACH),0.1E-07)
      A = 0.0E+00
      B = 0.1E+01
      POINTS(1) = P1
      POINTS(2) = P2
      CALL QAGP(F1P,A,B,NPTS2,POINTS,EPSABS,EPSREL,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      ERROR = ABS(RESULT-EXACT1)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.0.AND.ERROR.LE.EPSREL*ABS(EXACT1)) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL CPRIN(LUN,0,KPRINT,IP,EXACT1,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 1
C
      LENIW = 10
      LENW = LENIW*2-NPTS2
      CALL QAGP(F1P,A,B,NPTS2,POINTS,EPSABS,EPSREL,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.1) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL CPRIN(LUN,1,KPRINT,IP,EXACT1,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 2, 4, 1 OR 3
C
      NPTS2 = 3
      POINTS(1) = 0.1E+00
      LENIW = LIMIT*2+NPTS2
      LENW = LIMIT*4+NPTS2
      UFLOW = R1MACH(1)
      A = 0.1E+00
      CALL QAGP(F2P,A,B,NPTS2,POINTS,UFLOW,0.0E+00,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IERV(2) = 4
      IERV(3) = 1
      IERV(4) = 3
      IP = 0
      IF(IER.EQ.2.OR.IER.EQ.4.OR.IER.EQ.1.OR.IER.EQ.3) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL CPRIN(LUN,2,KPRINT,IP,EXACT2,RESULT,ABSERR,NEVAL,IERV,4)
C
C TEST ON IER = 3 OR 4 OR 1 OR 2
C
      NPTS2 = 2
      LENIW = LIMIT*2+NPTS2
      LENW = LIMIT*4+NPTS2
      A = 0.0E+00
      B = 0.5E+01
      CALL QAGP(F3P,A,B,NPTS2,POINTS,UFLOW,0.0E+00,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IERV(2) = 4
      IERV(3) = 1
      IERV(4)=2
      IP = 0
      IF(IER.EQ.3.OR.IER.EQ.4.OR.IER.EQ.1.OR.IER.EQ.2) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL CPRIN(LUN,3,KPRINT,IP,EXACT3,RESULT,ABSERR,NEVAL,IERV,4)
C
C TEST ON IER = 5
C
      B = 0.1E+01
      CALL QAGP(F4P,A,B,NPTS2,POINTS,EPSABS,EPSREL,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.5) IP = 1
      IF(IP.EQ.0) IPASS = 0
      OFLOW = R1MACH(2)
      CALL CPRIN(LUN,5,KPRINT,IP,OFLOW,RESULT,ABSERR,NEVAL,IERV,1)
C
C TEST ON IER = 6
C
      NPTS2 = 5
      LENIW = LIMIT*2+NPTS2
      LENW = LIMIT*4+NPTS2
      POINTS(1) = P1
      POINTS(2) = P2
      POINTS(3) = 0.3E+01
      CALL QAGP(F1P,A,B,NPTS2,POINTS,EPSABS,EPSREL,RESULT,ABSERR,NEVAL,
     *  IER,LENIW,LENW,LAST,IWORK,WORK)
      IERV(1) = IER
      IP = 0
      IF(IER.EQ.6.AND.RESULT.EQ.0.0E+00.AND.ABSERR.EQ.0.0E+00.AND.
     *  NEVAL.EQ.0.AND.LAST.EQ.0) IP = 1
      IF(IP.EQ.0) IPASS = 0
      CALL CPRIN(LUN,6,KPRINT,IP,EXACT1,RESULT,ABSERR,NEVAL,IERV,1)
C
      IF (KPRINT.GE.1) THEN
         IF (IPASS.EQ.0) THEN
            WRITE(LUN, '(/'' SOME TEST(S) IN CQAGP FAILED''/)')
         ELSEIF (KPRINT.GE.2) THEN
            WRITE(LUN, '(/'' ALL TEST(S) IN CQAGP PASSED''/)')
         ENDIF
      ENDIF
      RETURN
      END
