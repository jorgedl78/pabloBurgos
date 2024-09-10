  MEMBER('comision.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('COMISBC0.CLW')
COMISBC0:DctInit             PROCEDURE
COMISBC0:DctKill             PROCEDURE
COMISBC0:FilesInit           PROCEDURE
    END
    MODULE('COMISBC1.CLW')
COMISBC1:DctInit             PROCEDURE
COMISBC1:DctKill             PROCEDURE
COMISBC1:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  COMISBC0:DctInit
  COMISBC1:DctInit
  COMISBC0:FilesInit
  COMISBC1:FilesInit


DctKill PROCEDURE
  CODE
  COMISBC0:DctKill
  COMISBC1:DctKill

