
package com.aem.crash.test
{

    import flash.display.Sprite;
    import flash.geom.Point;

    import com.aem.crash.IBody;

    public class ExampleBody extends Sprite implements IBody
    {
        private static const COLORS:Array = [
            0x0000FF,
            0x00FF00,
            0xFF0000,
            0xFFFF00,
            0x00FFFF
        ];

        private var position:Point = new Point();
        public var xVelocity:Number = 0;
        public var yVelocity:Number = 0;

        private var color:uint;

        public function ExampleBody():void
        {
            var c:uint = Math.floor(Math.random() * COLORS.length);
            color = COLORS[c];
            graphics.beginFill(COLORS[c]);
            graphics.drawRect(-8, -8, 16, 16);
            graphics.endFill();
        }

        public function set highlight(value:Boolean):void
        {
            var p:Point = new Point();
            p.x = getX();
            p.y = getY();
            p = globalToLocal(p);
            var w:Number = getWidth();
            var h:Number = getHeight();
            if (value)
            {
                graphics.clear();
                graphics.beginFill(0x000000);
                graphics.drawRect(p.x, p.y, w, h);
                graphics.endFill();
            } else {
                graphics.clear();
                graphics.beginFill(color);
                graphics.drawRect(p.x, p.y, w, h);
                graphics.endFill();
            }
        }

        public function getX():Number
        {
            return x - (getWidth() / 2);
        }

        public function getY():Number
        {
            return y - (getHeight() / 2);
        }

        public function setPosition(x:Number, y:Number):void
        {
            this.x = x + (getWidth() / 2);
            this.y = y + (getHeight() / 2);
        }
        
        public function getWidth():Number
        {
            return width;
        }

        public function getHeight():Number
        {
            return height;
        }
    }
}
