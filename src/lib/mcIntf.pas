(* === mcIntf ===
 * Ver: 1.0.0
 *  By: Igor Nunes
 * Extension/plugin interfaces for Mini Calc. *)

{$mode objfpc}
unit mcIntf;

interface

const
   MAXLIST = 1000;

type
   TMCResultType = (mcBoolean, mcInteger, mcFloat, mcDateTime, mcString);
   TMCResult = record
      ResString   : WideString;
      case ResultType : TMCResultType of
         mcBoolean  : (ResBoolean  : Boolean);
         mcInteger  : (ResInteger  : Int64);
         mcFloat    : (ResFloat    : Double);
         mcDateTime : (ResDateTime : TDatetime);
         mcString   : ();
   end;
   
   TArrayDouble = array [1..MAXLIST] of double;
   TList = record
              data   : TArrayDouble;
              id     : WideString;
              count  : word;
              active : boolean;
           end;
   
   TZoom = record
      xMin, xMax, xScl : real;
      yMin, yMax, yScl : real;
   end;
   
   IPluginHost = interface ['{415AE774-2685-4737-B60E-F5BD7B96EF4D}']
      (* Expression Parser *)
      function Compute(expression : WideString) : TMCResult;
      procedure SetFloatVariable(id : WideString; v : Double);
      function GetFloatVariable(id : WideString) : Double;
      function GetStringVariable(id : WideString) : WideString;
      procedure SetStringVariable(id : WideString; v : WideString);
      
      (* List Manager *)
      function CreateList(id : WideString) : boolean;
      procedure DeleteList(id : WideString);
      procedure DeleteList(i : word); overload;
      
      function AppendToList(id : WideString; value : Double) : boolean;
      function AppendToList(i : LongInt; value : Double) : boolean; overload;
      function AddToList(id : WideString; value : Double; ind : word) : boolean;
      function AddToList(i : LongInt; value : Double; ind : word) : boolean; overload;
      function DeleteFromList(id : WideString; ind : word) : boolean;
      function DeleteFromList(i : LongInt; ind : word) : boolean; overload;
      
      function GetListCount : word;
      property NumberOfLists : word read GetListCount;
      
      function GetListStr(const ID : WideString) : TList;
      property ListByName  [s : WideString] : TList read GetListStr;
      
      function GetList(const I : word) : TList;
      property ListByIndex [i : word]       : TList read GetList;
      
      function GetListElement(const ID : WideString; const I : LongInt) : Double;
      procedure SetListElement(const ID : WideString; const I : LongInt; thevalue : Double);
      property ListElement[s : WideString; i : LongInt] : Double read GetListElement write SetListElement;
      
      function GetListElemCountStr(const ID : WideString) : word;
      function GetListElemCount(const I : word) : word;
      property NumberOfElementsByName  [s : WideString] : word read GetListElemCountStr;
      property NumberOfElementsByIndex [i : word]   : word read GetListElemCount;
      
      (* Function manager *)
      procedure SetFunction(i : word; fn : WideString);
      function GetFunction(i : word) : WideString;
      
      procedure SetFunctionVisibility(i : word; state : boolean);
      procedure SwapFunctionVisibility(i : word);
      function GetFunctionVisibility(i : word) : boolean;
      
      procedure SetPlotterZoom(zoom : TZoom);
      function GetPlotterZoom : TZoom;
      property PlotterZoom : TZoom read GetPlotterZoom write SetPlotterZoom;
      
      (* Anything else? *)
      // Not yet...
   end;
   
   IPlugin = interface ['{C9EEF4FC-1CF2-4350-9172-9428F3701E22}']
      function GetMyName : WideString;                  // Private
      property PluginName : WideString read GetMyName;  // Public or Published - Mini Calc uses this to load the Plugin Menu.
      procedure Execute;  // Public or Published - it's the method with which the plugin is called from Mini Calc.
   end;


implementation
   // void
end.