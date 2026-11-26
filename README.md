# jnr-Jenner-Analytics-create-macro-arrays-from-lists-ranges-column-values-and-column-names
Jenner Analytics create macro arrays from lists ranges column values and column names

    /*---
    c:/utl/jnr-Jenner-Analytics-create-macro-arrays-from-lists-ranges-column-values-and-column-names.sas
    ---*/

    Jenner Analytics create macro arrays from lists ranges column values and column names
     
    Too long to post
    jnr_array
    https://tinyurl.com/4ynx85vx
    https://github.com/rogerjdeangelis/jnr-Jenner-Analytics-create-macro-arrays-from-lists-ranges-column-values-and-column-name

    Related
    jnr_varlist
    https://tinyurl.com/mrp6dapy
    https://github.com/rogerjdeangelis/jnr-Jenner-Analytics-macro-function-to-create-a-curated-list-of-table-column-names

    jnr_do_over
    Too long to post; see
    https://tinyurl.com/4sa4berm
    https://github.com/rogerjdeangelis/jnr-Jenner-analytics-dynamic-code-generation-pivot-wide-sql-arrays-do-over

    CONTENTS
      1 ENVIROMRNT
      2 INPUT
      3 PROCESS & OUTPUT
      4 LOG
      5 MACRO JNR_ARRAY
      
    /**************************************************************************************************************************/
    /* 1  ENVIROMENT                                                                                                          */
    /**************************************************************************************************************************/

    Used with %jnr_do_over, you can loop over lists and 
    write one statement per array value.
    The statements can be SQL, R, Python, PowerShell, or any other language.
    Repetitive statements can be faster then looping.

    Jenner macro code can sit inline, between R, 
    Python, PowerShell... statements.
    You don't need a separate preprocessing step.

    Macro %DOSUBL lets you drop down to a
    inline subroutine in another language in the middle of a workflow.
    The subroutine can contain valid statements in any language.
    I call these drop-down inline subroutines.

    A good fit for SQL, I call the solution 'sql arrays'.
    SQL queries repeat the same clauses over many columns or tables,
    such as SELECT lists, UNIONS CASE expressions, joins, and GROUP BY lists.
    Macro arrays generate those repeated clauses from a list,
    so you write the pattern once instead of typing each line.
     
    /**************************************************************************************************************************/
    /* 2  INPUT                                                                                                               */
    /**************************************************************************************************************************/

    HARDCODED IN VALUES ARGUMENT OF JNR_ARRAY MACRO

    values = a5 a6           
    values = a5-a7           
    values = 5-7             
    values = sashelp.class(obs=3 keep=name)  
    values = %jnr_varlist(libname=sashelp,memname=class) 

    proc print data=jenhelp.class;
    run;

    /*---
    LIST: 26NOV2026:09:57:24

    Obs    Name       Sex    Age    Height    Weight

      1    Amir        M      13     61.2       95.0
      2    Bethany     F      14     63.8      105.0
      3    Carlos      M      12     58.5       88.0
    ...
     19    Samuel      M      14     66.0      120.0
    ---*/

    HARDCODED ARGUMENT IN JNR_ARRAY VALUES ARGUMENT

    values = a5 a6           
    values = a5-a7           
    values = 5-7  

    USING TABLE ABOVE
    values = sashelp.class(obs=3 keep=name)  
    values = %jnr_varlist(libname=sashelp,memname=class) 

    /**************************************************************************************************************************/
    /* 3  PROCESS & OUTPUT                                                                                                    */
    /**************************************************************************************************************************/

    %macro jnr_array(
         case=range
        ,arrayName=vars
        ,values=a5-a7
        )/des="Jenner Analytics create a macro array from 
            lists, ranges, table column values, and column names";
    ....
    %mend jnr_array;

    %jnr_array(case=list,arrayName=v,values=a5 a6 a7 );
        %put &=v1 &=v2 &=v3 &=vn ;

        ANSWER: V1=a5 V2=a6 V3=a7 VN=3
        
    %jnr_array(case=range,arrayName=v,values=a5-a7    );
       %put &=v1 &=v2 &=v3 &=vn ;

       ANSWER: V1=a5 V2=a6 V3=a7 VN=3
       
    %jnr_array(case=range,arrayName=v,values=5-7      );
       %put &=v1 &=v2 &=v3 &=vn ;

       ANSWER: V1=5 V2=6 V3=a7 VN=3
       
    %jnr_array(case=table,arrayName=v,values=sashelp.class(obs=3 keep=name) );
       %put &=v1 &=v2 &=v3 &=vn ;

       ANSWER: V1=Amir V2=Bethany V3=Carlos VN=3
       
    %jnr_array(case=macro,arrayName=v,
      values=%jnr_varlist(libname=sashelp,memname=class));
       %put &=v1 &=v2 &=v3 &=v4 &=v5 &=vn ;

       ANSWER: V1=NAME V2=SEX V3=AGE V4=HEIGHT V5=WEIGHT VN=5
     
    /**************************************************************************************************************************/
    /* 3  LOG %jnr_array(case=list,arrayName=v,values=a5 a6 a7 );                                                             */
    /**************************************************************************************************************************/

    NOTE: Copyright (c) 2026 Jenner Analytics Ltd., London, England.
    NOTE: Jenner v1.5.125 (build v1.5.125+22203d2bc1.20261120T060416Z)
          Licensed to Roger DeAngelis, Serial 3BF7B3E6.
    NOTE: Option VALIDVARNAME changed to UPCASE.
    NOTE: Option FORMCHAR changed to |----|+|---+=|-/\<>*.
    NOTE: DATA _null_

    autoexec started  26NOV2026:10:23:55

    NOTE: DATA elapsed:
      wall  0.00 seconds
      cpu   0.00 seconds
    NOTE: Library WORKX assigned path=d:/wpswrkx.
    NOTE: Library LIBRARY assigned path=d:/wpswrkx.
    NOTE: DATA WORKX.CLASS

    NOTE: Processing inline DATALINES (19 lines)

    NOTE: The data set WORKX.CLASS has 19 observations and 5 variables.
    NOTE: DATA elapsed:
      wall  0.00 seconds
      cpu   0.00 seconds
    NOTE: DATA _null_

    LOG:  26NOV2026:10:23:55
    NOTE: DATA _null_ completed. Output written to FILE PRINT
    NOTE: Option SASAUTOS changed to c:/otojnr.
    NOTE: DATA _null_

    NOTE: Reading from fileref c:/jnr/runsas_selection.sas (c:/jnr/runsas_selection.sas)
    1 %jnr_array(case=list,arrayName=v,values=a5 a6 a7 );

    NOTE: 1 records were read from the infile 'c:/jnr/runsas_selection.sas'.
    NOTE: DATA elapsed:
      wall  0.00 seconds
      cpu   0.02 seconds
    NOTE: DATA _null_

    autoexec completed  26NOV2026:10:23:55

    NOTE: DATA elapsed:
      wall  0.00 seconds
      cpu   0.00 seconds
    NOTE: DATA _null_

    NOTE: DATA elapsed:
      wall  0.00 seconds
      cpu   0.00 seconds

    /**************************************************************************************************************************/
    /* 4  MACRO                                                                                                               */
    /**************************************************************************************************************************/

    filename ft15f001 "c:/otojnr/jnr_array.sas";
    parmcards4;
    %macro jnr_array(
         case=range
        ,arrayName=vars
        ,values=a5-a7
        )/des="Jenner Analytics create a macro array from 
            lists, ranges, table column values, and column names";

       %let case=%upcase(&case);

       /*--- ADD A CASE FOR NUMERIC RANGES LIKE 5-7 ---*/
       %if &case = RANGE and %sysfunc(indexc(%substr(&values,1,1),0123456789)) ^= 0 %then %do;
           %let case=NUMRANGE;
           %let values=%qsysfunc(translate(&values,":","-"));
           %put NOTE: &=values;
           %put NOTE: &=NUMRANGE;
       %end;

      /**************************************************************************************************************************/
      /*  CASE LIST OR MACRO A5 A6 A7                                                                                           */
      /**************************************************************************************************************************/

       %if &case = LIST | &case=MACRO %then %do;

       data _null_;

         length name $32;
         values = "&values";

         do idx=1 to countw(values);

           name  = cats("&arrayName",idx);
           value = scan(values,idx);
           call symputx(name,value,'G');

         end;
         name  = cats("&arrayName","N");
         call symputx(name,idx-1,'G');

      run;
    %end;

     /**************************************************************************************************************************/
     /*  CASE NUMRANGE 5-7                                                                                                     */
     /**************************************************************************************************************************/

    %else %if &case = NUMRANGE %then %DO;

        data _null_;
           array &arrayName.[&values];
           do idx=lbound(&arrayName) to hbound(&arrayname);
             name  = cats("&arrayName",idx-(lbound(&arrayName)-1));
             value = idx;
             call symputx(name,value,"G");
           end;
           name=cats("&arrayName","n");
           value=dim(&arrayName);
           call symputx(name,value,"G");
        run;

    %end;

     /**************************************************************************************************************************/
     /*  CASE RANGE a5-a7                                                                                                      */
     /**************************************************************************************************************************/

    %else %if &case = RANGE %then %DO;

        data _null_;
           array &arrayName.[*] $32 &values;
           do idx= lbound(&arrayName) to hbound(&arrayName);
             name  = cats("&arrayName",idx-(lbound(&arrayName)-1));
             value = vname(&arrayName[idx]);
             call symputx(name,value,"G");
           end;
           name=cats("&arrayName","n");
           value=dim(&arrayName);
           call symputx(name,value,"G");
        run;

    %end;

     /**************************************************************************************************************************/
     /*  CASE TABLE  sashelp.class(obs=3 keep=name)                                                                            */
     /**************************************************************************************************************************/

    %else %if &case = TABLE %then %do;

      data _null_;
        array ary[1] _all_;
        set &values end=last;
        nam=vname(ary[1]);
        call symputx(cats("&arrayname",_n_), ary[1], 'G');
        if last then call symputx("&arrayname.n", _n_, 'G');
      run;

     %end;

     /**************************************************************************************************************************/
     /*  CASE TABLE  sashelp.class(obs=3 keep=name)                                                                            */
     /**************************************************************************************************************************/

     %else %if &case = MACRO %then %do;

        %let values=%unquote(&values);

        data _null_;

         length name $32;
         values = "&values";

         do idx=1 to countw(values);

           name  = cats("&arrayName",idx);
           value = scan(values,idx);
           call symputx(name,value,'G');

         end;
         name  = cats("&arrayName","N");
         call symputx(name,idx-1,'G');

      run;

     %end;

    %mend jnr_array;
    ;;;;
    run;

    /*--- END ---*/
