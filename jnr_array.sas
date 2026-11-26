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
