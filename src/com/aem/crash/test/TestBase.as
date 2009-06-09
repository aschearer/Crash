
package com.aem.crash.test
{

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    import com.aem.crash.Grid;

    class TestBase extends Sprite
    {

        var header:Sprite;
        var grid:Grid;
        var bodies:Array;

        function get status():TextField
        {
            return TextField(header.getChildByName("status"));
        }
    
        private var debug:Sprite;

        public function TestBase(title:String):void
        {
            header = TestUtils.getHeader();
            TextField(header.getChildByName("title")).text = title;
            addChild(header);

            grid = new Grid(50, 50);
            bodies = [];

            debug = new Sprite();
            addChildAt(debug, 0);

            addEventListener(Event.ENTER_FRAME, update);
        }

        public function update(e:Event):void
        {
            grid.debug(debug.graphics);
            debug.graphics.lineStyle(1, 0x000000, .2);
            for (var x:uint = 0; x < (550 / 50); x++)
            {
                for (var y:uint = 0; y < (400 / 50); y++)
                {
                    debug.graphics.drawRect(x * 50, y * 50, 50, 50);
                }
            }
        }

        public override function addChild(child:DisplayObject):DisplayObject
        {
            return addChildAt(child, 0);
        }
    }
}
