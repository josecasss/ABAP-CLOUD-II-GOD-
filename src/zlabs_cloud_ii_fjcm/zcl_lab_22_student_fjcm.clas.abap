class zcl_lab_22_student_fjcm definition inheriting from zcl_lab_21_classroom_fjcm
  public
  final
  create public .

  public section.

    methods: assign_student.

  protected section.
  private section.
endclass.

class zcl_lab_22_student_fjcm implementation.

  method assign_student.
    data(lo_student) = new zcl_lab_21_classroom_fjcm( ).
  endmethod.

endclass.
