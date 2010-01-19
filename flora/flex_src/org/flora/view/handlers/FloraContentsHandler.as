package org.flora.view.handlers {

    import flash.utils.Dictionary;

    import mx.containers.Canvas;
    import mx.core.IMXMLObject;
    import mx.events.FlexEvent;

    import org.flora.view.FloraContents;

    public class FloraContentsHandler implements IMXMLObject {

    	private var doc:FloraContents;

    	// Array of LeafLayoutManagers
    	private var leafLayoutManagers:Array = new Array();

    	// Stores the xml data keyed off of LeafLayoutManager
    	private var leafDataDictionary:Dictionary = new Dictionary();
    	private var leafHash:Object = new Object();

		// 초기화 이벤트 핸들러
        public function initialized(doc:Object, id:String):void {
            this.doc = FloraContents(doc);
            this.doc.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

		// creation complete 이벤트 핸들러
        private function creationCompleteHandler(e:FlexEvent):void {

        }
    }
}