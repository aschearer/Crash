
package com.aem.crash.test
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    import com.aem.crash.Grid;
    import com.aem.crash.Utils;
    import com.aem.crash.IBody;

    public class NeighborhoodTest extends Sprite
    {

        var test:TestBase;

        private var following:Boolean;
        private var offsetX:Number;
        private var offsetY:Number;
        private var selected:ExampleBody;
        private var target:ExampleBody;
        private var counter:uint;

        public function NeighborhoodTest():void
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
            addEventListener(Event.REMOVED_FROM_STAGE, clean);
        }

        public function init(e:Event):void
        {
            createTest();
            createBodies();
            addEventListener(Event.ENTER_FRAME, update);
            stage.addEventListener(MouseEvent.CLICK, click);
        }

        public function clean(e:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, update);
            stage.removeEventListener(MouseEvent.CLICK, click);
            parent.removeChild(test);
            test = null;
        }

        private function createTest():void
        {
            test = new TestBase("Body's Neighbors");
            parent.addChild(test);
        }

        private function createBodies():void
        {
            var b:ExampleBody = null;
            for (var i:uint = 0; i < 35; i++)
            {
                b = new ExampleBody();
                b.setPosition(Math.random() * 550, Math.random() * 350 + 25);
                b.visible = false;
                test.addChild(b);
                test.bodies.push(b);
            }
            selected = test.bodies[0];
            selected.highlight = true;

            var r:uint = Math.floor((test.bodies.length - 2) * Math.random());
            r++;
            target = test.bodies[r];
        }

        public function update(e:Event):void
        {
            for (var i:uint = 0; i < test.bodies.length; i++)
            {
                test.bodies[i].visible = false;
            }

            selected.visible = true;

            counter++;
            if (counter > 20)
            {
                target.highlight = true;
                target.visible = true;
                if (counter > 40)
                {
                    target.highlight = false;
                    target.visible = false;
                    counter = 0;
                }
            }

            var neighbors:Array = test.grid.neighborhood(selected, test.bodies);

            for (var j:uint = 0; j < neighbors.length; j++)
            {
                neighbors[j].visible = true;
            }
            test.status.text = test.bodies.length + " bodies total " + neighbors.length + " neighboring bodies";
        }


        public function click(e:MouseEvent):void
        {
            for (var i:uint = 0; i < test.bodies.length; i++)
            {
                var body:ExampleBody = test.bodies[i];
                if (body.getX() < e.stageX &&
                    body.getX() + body.getWidth() > e.stageX &&
                    body.getY() < e.stageY &&
                    body.getY() + body.getHeight() > e.stageY)
                {
                    selected.highlight = false;
                    selected = body;
                    selected.highlight = true;
                    break;
                }
            }
            if (selected == target)
            {
                var r:uint = Math.floor((test.bodies.length - 1) * Math.random());
                r++;
                while (test.bodies[r] == target)
                {
                    r = Math.floor((test.bodies.length - 1) * Math.random());
                }
                target = test.bodies[r];
            }
        }
    }
}
