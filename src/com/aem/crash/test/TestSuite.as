
package com.aem.crash.test
{

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.text.TextField;

    public class TestSuite extends Sprite
    {
        private var cases:Array = [
            new CullTest(),
            new NeighborhoodTest()
        ];

        private var current:uint = 0;
        private var page:TextField;

        public function TestSuite():void
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        public function init(e:Event):void
        {
            addChild(cases[current]);
            var footer:Sprite = TestUtils.getFooter();
            addChild(footer);
            page = TextField(footer.getChildByName("page"));
            page.text = (current + 1) + " / " + (cases.length);
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
        }

		public function onKeyRelease(e:KeyboardEvent):void 
        {
            var next:uint = cases.length + 1;
            if (e.keyCode == Keyboard.LEFT)
            {
                next = (cases.length + current - 1) % cases.length;
            }
            if (e.keyCode == Keyboard.RIGHT)
            {
                next = (cases.length + current + 1) % cases.length;
            }
            
            if (next < cases.length && next != current)
            {
                removeChild(cases[current]);
                addChild(cases[next]);
                current = next;
                page.text = (current + 1) + " / " + (cases.length);
            }
        }
    }
}
