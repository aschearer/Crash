
package com.aem.crash.test
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFormat;

    import com.aem.crash.Grid;
    import com.aem.crash.Utils;
    import com.aem.crash.IBody;

    public class CullTest extends Sprite
    {

        var test:TestBase;

        private var following:Boolean;
        private var offsetX:Number;
        private var offsetY:Number;
        private var viewport:ExampleBody;
        private var instructions:TextField;

        public function CullTest():void
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
            addEventListener(Event.REMOVED_FROM_STAGE, clean);
            instructions = TestUtils.createInstrunctions();
            instructions.text = "Drag me";
        }

        public function init(e:Event):void
        {
            createTest();
            createBodies();
            createViewport();
            addEventListener(Event.ENTER_FRAME, update);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, drag);
            stage.addEventListener(MouseEvent.MOUSE_UP, drop);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, follow);
            instructions.visible = true;
            parent.addChildAt(instructions, parent.numChildren);
        }

        public function clean(e:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, update);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, drag);
            stage.removeEventListener(MouseEvent.MOUSE_UP, drop);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, follow);
            parent.removeChild(instructions);
            parent.removeChild(test);
            test = null;
        }

        private function createTest():void
        {
            test = new TestBase("Cull Bodies");
            parent.addChild(test);
        }

        private function createViewport():void
        {
            viewport = new ExampleBody();
            viewport.graphics.clear();
            viewport.graphics.lineStyle(1);
            viewport.graphics.drawRect(-(550 / 2), -(400 / 2), 275, 200);
            viewport.setPosition(550 / 4, 400 / 4);
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
        }

        public function update(e:Event):void
        {
            for (var i:uint = 0; i < test.bodies.length; i++)
            {
                test.bodies[i].visible = false;
            }

            var onscreen:Array = test.grid.cull(viewport, test.bodies);
            for (var j:uint = 0; j < onscreen.length; j++)
            {
                onscreen[j].visible = true;
            }
            test.status.text = test.bodies.length + " bodies total " + onscreen.length + " visible bodies";


            graphics.clear();
            graphics.lineStyle(1);
            graphics.drawRect(viewport.getX(), viewport.getY(),
                    viewport.getWidth(), viewport.getHeight());

            instructions.x = viewport.getX()  + 3;
            instructions.y = viewport.getY() + viewport.getHeight() - 18;
        }

        public function drag(e:MouseEvent):void
        {
            if (e.stageX > viewport.getX() &&
                e.stageX < viewport.getX() + viewport.getWidth() &&
                e.stageY > viewport.getY()  &&
                e.stageY < viewport.getY()  + viewport.getHeight())
            {
                following = true;
                instructions.visible = false;
                offsetX = e.stageX - viewport.getX()  - viewport.getWidth() / 2;
                offsetY = e.stageY - viewport.getY()  - viewport.getHeight() / 2;
            }
        }

        public function drop(e:MouseEvent):void
        {
            following = false;
        }

        public function follow(e:MouseEvent):void
        {
            if (following)
                viewport.setPosition(e.stageX - 550 / 4 - offsetX, 
                    e.stageY - 400 / 4 - offsetY);
        }

    }
}
