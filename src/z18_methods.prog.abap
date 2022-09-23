*&---------------------------------------------------------------------*
*& Report z18_methods
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z18_methods.

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

    PROTECTED SECTION.

        DATA: mv_name TYPE string,
              mv_planetype TYPE saplane-planetype.


    PRIVATE SECTION.

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

CLASS lcl_cargo_plane DEFINITION
    INHERITING FROM lcl_airplane.

        PUBLIC SECTION.
            METHODS:
                constructor
                    IMPORTING
                          iv_name TYPE string
                          iv_planetype TYPE saplane-planetype
                          iv_weight TYPE i
                     RAISING
                         cx_s4d400_wrong_plane,

                get_weight
                    RETURNING
                        VALUE(mv_weight) TYPE i,

                get_attributes REDEFINITION.


        PRIVATE SECTION.
            DATA:   mv_weight TYPE i.

ENDCLASS.

CLASS lcl_cargo_plane IMPLEMENTATION.

  METHOD get_attributes.

        et_attributes = VALUE #( ( attribute = 'NAME' value = mv_name )
                                 ( attribute = 'PLANETYPE' value = mv_planetype )
                                 ( attribute = 'weight' value = mv_weight )
        ) .

  ENDMETHOD.

  METHOD constructor.

    super->constructor( iv_name = iv_name iv_planetype = iv_planetype ).
    mv_weight = iv_weight.


  ENDMETHOD.

  METHOD get_weight.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.

    public SECTION.
        METHODS:
            constructor
                IMPORTING
                    iv_name TYPE string
                    iv_planetype TYPE saplane-planetype
                    iv_seats TYPE i
                RAISING
                    cx_s4d400_wrong_plane,

            get_attributes REDEFINITION.

    private SECTION.
        DATA:
           mv_seats TYPE i.
ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.

  METHOD constructor.

    super->constructor( iv_name = iv_name iv_planetype = iv_planetype ).
    mv_seats = iv_seats.

  ENDMETHOD.

  METHOD get_attributes.
    super->get_attributes(  ).
    et_attributes = VALUE #( ( attribute = 'SEATS' value = mv_seats ) ) .
  ENDMETHOD.

ENDCLASS.


CLASS lcl_carrier DEFINITION.

     PUBLIC SECTION.

            TYPES:
                    tt_planetab TYPE STANDARD TABLE OF REF TO lcl_airplane WITH EMPTY KEY.

            METHODS:

                    add_plane
                      IMPORTING
                        iv_plane TYPE REF TO lcl_airplane,

                    get_plane
                        RETURNING
                            VALUE(iv_planes) TYPE tt_planetab,

                    get_highest_cargo_weight
                    RETURNING
                        VALUE(rv_weight) TYPE i.


     PRIVATE SECTION.

            DATA: mt_planes TYPE tt_planetab.


ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD add_plane.

    mt_planes = VALUE #( BASE mt_planes ( iv_plane ) ).

  ENDMETHOD.

  METHOD get_highest_cargo_weight.

    DATA: lo_plane TYPE REF TO lcl_airplane,
          lo_cargo TYPE REF TO lcl_cargo_plane,
          lv_weight TYPE i.

    LOOP AT mt_planes INTO lo_plane.

    IF lo_plane IS INSTANCE OF lcl_cargo_plane.
 lo_cargo = CAST #( lo_plane ).
 lv_weight = lo_cargo->get_weight( ).

    IF lv_weight GT rv_weight.
        rv_weight = lv_weight.
    ENDIF.
    ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_plane.

        iv_planes = mt_planes.

  ENDMETHOD.

ENDCLASS.


DATA: go_airplane TYPE REF TO lcl_airplane,
      gt_airplanes TYPE STANDARD TABLE OF REF TO lcl_airplane,
      gt_attributes TYPE lcl_airplane=>tt_attributes,
      gt_output type go_airplane->tt_attributes, "Funktionert beides
      go_carrier TYPE REF to lcl_carrier,
      go_passenger TYPE REF TO lcl_passenger_plane,
      go_cargo TYPE REF TO lcl_cargo_plane.



START-OF-SELECTION.

    go_carrier = new #( ).
    TRY.
        go_airplane = new #( iv_name = 'baum' iv_planetype = 'A380' ).
        go_carrier->add_plane( go_airplane ).

        go_cargo = new #( iv_name = 'baum1' iv_planetype = 'A380' iv_weight = '1000' ).
        go_carrier->add_plane( go_cargo ).

        go_passenger = new #( iv_name = 'baum2' iv_planetype = 'A380' iv_seats = '1000').
        go_carrier->add_plane( go_passenger ).

    CATCH CX_S4D400_WRONG_PLANE.
ENDTRY.

    gt_airplanes = go_carrier->get_plane(  ).


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
