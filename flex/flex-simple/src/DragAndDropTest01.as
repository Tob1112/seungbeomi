import mx.controls.Alert;
import mx.core.DragSource;
import mx.events.*;
import mx.managers.DragManager;

private var correct:Object = {                   // 正解
    opt0: 'ans1', opt1: 'ans2', opt2: 'ans0'
}

// 採点
private function doSubmit(event:MouseEvent):void {
    var points:int = 0;
    var max:int = 0;
    var key:String;
    for (key in correct) {
        var answer:String = this[key].parent.id;
        points += (correct[key] == answer) ? 1: 0;
        ++max;
    }
    var score:int = Math.floor(points / max * 100);
    var judge:String = (score >= 70) ? '合格': '不合格';
    Alert.show(judge + '：' + score + '%');
}

// ドラッグ開始
private function doDragStart(event:MouseEvent):void {
    var dragInitiator:Box = Box(event.currentTarget);
    DragManager.doDrag(dragInitiator, new DragSource(), event);
}

// ドロップゾーンに入った
private function doDragEnter(event:DragEvent):void {
    var dropzone:Box = Box(event.currentTarget);
    if (dropzone.getChildren().length == 0) {
        dropzone.setStyle('backgroundColor', '#FFA500');    /* orange */
        DragManager.acceptDragDrop(dropzone);   /* ドロップの受け入れ可能 */
    }
}

// ドロップゾーンから出た
private function doDragExit(event:DragEvent):void {
    var dropzone:Box = Box(event.currentTarget);
    dropzone.setStyle('backgroundColor', 'white');
}

// ドロップされた
private function doDragDrop(event:DragEvent):void {
    var dropzone:Box  = Box(event.currentTarget);
    var draggable:Box = Box(event.dragInitiator);
    dropzone.setStyle('backgroundColor', 'white');
    dropzone.addChild(draggable);
}

// 要素にリスナを追加
private function init():void {
    var i:int;
    for(i = 0; i < 3; ++i) {
        this['opt'+i].addEventListener('mouseDown', doDragStart);
        this['ans'+i].addEventListener('dragEnter', doDragEnter);
        this['ans'+i].addEventListener('dragExit',  doDragExit);
        this['ans'+i].addEventListener('dragDrop',  doDragDrop);
        this['tmp'+i].addEventListener('dragEnter', doDragEnter);
        this['tmp'+i].addEventListener('dragExit',  doDragExit);
        this['tmp'+i].addEventListener('dragDrop',  doDragDrop);
    }
    this['submit'].addEventListener('click', doSubmit);
}
