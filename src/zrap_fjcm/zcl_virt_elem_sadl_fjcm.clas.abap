class zcl_virt_elem_sadl_fjcm definition
  public
  final
  create public .

  public section.
    interfaces: if_sadl_exit_calc_element_read. "Clase para el Virtual Element SADL
  protected section.
  private section.
endclass.

class zcl_virt_elem_sadl_fjcm implementation.

  method if_sadl_exit_calc_element_read~get_calculation_info.

    case iv_entity. "Para indentificar la Entidad

      when 'Z_C_TRAVEL_FJCM'. "Nombre de la entidad tiene que ser Projection

        loop at it_requested_calc_elements into data(ls_requested_calc_elem).

          if ls_requested_calc_elem = 'PRICEWITHVAT'. "Campo Virtual Element

            "Se podria con un append pero mejor queda asi y con este campo se trabajara
            insert conv #( 'TOTALPRICE' ) into table et_requested_orig_elements. "Tabla que contiene los elementos a utilizar

          endif.

        endloop.

    endcase.

  endmethod.

  method if_sadl_exit_calc_element_read~calculate.

    data: lt_original_data type standard table of z_c_travel_fjcm with default key. "Tabla

    lt_original_data = corresponding #( it_original_data ).

    "Logica
    loop at lt_original_data assigning field-symbol(<fs_original_data>).

      <fs_original_data>-PriceWithVAT = <fs_original_data>-TotalPrice * '1.21'.

    endloop.

    ct_calculated_data = corresponding #( lt_original_data ). "Se devuelve la tabla con el nuevo campo calculado

  endmethod.

endclass.
