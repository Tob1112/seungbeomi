package xpath
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import memorphic.parser.*;
    import memorphic.utils.*;
    import memorphic.xpath.*;

    import mx.controls.Alert;

    public class xmlRead extends Sprite
    {
        //--- Declare your Variables -------
        public var _loader:URLLoader;
        public var _xml:XML;
        public var XMLDONE:Event;
        public var data:*;
        //--------- Constructor ------
        public function xmlRead()
        {

        }
        //------------- Function to load XML File ----------
        public function loadData(xmlpath:String):void{
            //------------- Create a URL loader for Loading XML ----------
            _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE,onXMLLoaded);

            //---------- Create URLRequest Object for loading XML file -------
            var _urlRequest:URLRequest = new URLRequest("data/data.xml");
            try{
                _loader.load(_urlRequest);
                trace("XML Loaded Successfully");
            }
            catch(err:Error){
                trace("Error :: XML File not loaded");
            }
        }

        public function loadDataFromXMLFile(path:String):* {
            // ファイルからXML読み込み
            var file:File = new File(path);
            if (file.nativePath.indexOf("data.xml") != -1) {
                var stream:FileStream = new FileStream();
                stream.open(file, FileMode.READ);
                //xml = new XML(stream.readMultiByte(file.size, ENCODE));
                _xml = XML(stream.readUTFBytes(stream.bytesAvailable));
                stream.close();
                    //userDataGrid.dataProvider = xml.contact;
            } else {
                Alert.show("File not found. : " + file.nativePath);
            }
            return _xml;
        }
        //-------- Function to get Data from XML using XPATH -------------------
        public function getData(exp:String=null):*{
            try{
                if(_loader.data != undefined){
                    _xml = new XML(_loader.data);
                    var myQuery:XPathQuery;
                    if(exp == null)
                        myQuery = new XPathQuery("/");
                    else
                        myQuery = new XPathQuery(exp);
                    var myResult:XMLList = myQuery.exec(_xml);
                    return myResult;
                }else{
                    trace("XML data not loaded");
                    return null;
                }
            }
            catch(err:Error){
                trace(err.toString());
            }
        }
        public function getValue(xpath:String=null):* {
            try{
                var myQuery:XPathQuery;
                if(xpath == null) {
                    myQuery = new XPathQuery("/");
                } else {
                    myQuery = new XPathQuery(xpath);
                }
                var result:XMLList = myQuery.exec(_xml);
                return result;
            }
            catch(err:Error){
                trace(err.toString());
            }
        }
        //-------------- Dispatch a new event when XML gets Loaded ---------------
        private function onXMLLoaded(e:Event):void{
            data = e.target.data;
            dispatchEvent(new CustomEvent(CustomEvent.XML_DONE));
        }

    }
}

