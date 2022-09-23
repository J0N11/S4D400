*&---------------------------------------------------------------------*
*& Report z18_methods
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_class.

CLASS lcl_airplane DEFINITION.
    PUBLIC SECTION.

        TYPES:  BEGIN OF ts_attribute,
                 attribute TYPE string,
                 value TYPE string,
                END OF ts_attribute,
                tt_attributes TYPE STANDARD TABLE OF ts_attribute
                    WITH NON-UNIQUE KEY attribute.

        METHODS:
         constructor
                 IMPORTING
                     iv_name TYPE string
                     iv_planetype TYPE saplane-planetype

                      RAISING CX_S4D400_WRONG_PLANE,

         get_attributes
                 EXPORTING
                     et_attributes TYPE tt_attributes.

        CLASS-METHODS:
            class_constructor,

            get_n_o_airplanes
                EXPORTING
                    ev_number TYPE I.




    PRIVATE SECTION.

        DATA: mv_name TYPE string,
              mv_planetype TYPE saplane-planetype.

        CLASS-DATA: gv_n_o_airplanes TYPE i,
                    gt_planetypes TYPE STANDARD TABLE OF SAPLANE WITH NON-UNIQUE KEY planetype.


ENDCLASS.

CLASS lcl_airplane IMPLEMENTATION.

  METHOD constructor.

        IF NOT line_exists( gt_planetypes[ planetype = iv_planetype ] ).
          RAISE EXCEPTION TYPE cx_s4d400_wrong_plane.
             ENDIF.

        mv_name = iv_name.
        mv_planetype = iv_planetype.

        gv_n_o_airplanes += 1.

  ENDMETHOD.

  METHOD get_attributes.
       et_attributes = VALUE #( ( attribute = 'NAME' value = mv_name )
                              ( attribute = 'PLANETYPE' value = mv_planetype )
                               ).

  ENDMETHOD.

  METHOD get_n_o_airplanes.
    ev_number = gv_n_o_airplanes.
  ENDMETHOD.

  METHOD class_constructor.

        SELECT FROM SAPLANE FIELDS *
        INTO TABLE @gt_planetypes.


  ENDMETHOD.

ENDCLASS.

DATA: go_airplane TYPE REF TO lcl_airplane,
      gt_airplanes TYPE STANDARD TABLE OF REF TO lcl_airplane,
      gt_attributes TYPE lcl_airplane=>tt_attributes,
      gt_output type go_airplane->tt_attributes. "Funktionert beides


START-OF-SELECTION.

TRY.
 go_airplane = new #( iv_name = 'PLANE-1'
            iv_planetype = 'A380').

            gt_airplanes = VALUE #( BASE gt_airplanes (  go_airplane ) ).
CATCH CX_S4D400_WRONG_PLANE.
ENDTRY.


TRY.
  go_airplane = new #( iv_name = 'PLANE-2'
            iv_planetype = 'A380' ).

            gt_airplanes = VALUE #( BASE gt_airplanes (  go_airplane ) ).
CATCH CX_S4D400_WRONG_PLANE.
ENDTRY.

TRY.
  go_airplane = new #( iv_name = 'SPECK-3'
            iv_planetype = 'A380' ).

            gt_airplanes = VALUE #( BASE gt_airplanes (  go_airplane ) ).
CATCH CX_S4D400_WRONG_PLANE.
ENDTRY.

LOOP AT gt_airplanes INTO go_airplane.
    go_airplane->get_attributes(
    IMPORTING
        et_attributes = gt_attributes
    ).

    gt_output = CORRESPONDING #( BASE ( gt_output ) gt_attributes ).

ENDLOOP.










*TRY.
*    cl_salv_table=>factory(
*        IMPORTING
*          r_salv_table = DATA(alv)
*        CHANGING
*          t_table = gt_output
*      ).
*  CATCH cx_root.
*ENDTRY.
*
*alv->display( ).
