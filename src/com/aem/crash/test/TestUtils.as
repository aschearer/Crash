
package com.aem.crash.test
{

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    class TestUtils
    {

        public static function getHeader():Sprite
        {
            var header:Sprite = new Sprite();
            
            header.graphics.beginFill(0x363636);
            header.graphics.drawRect(0, 0, 550, 24);
            header.graphics.endFill();

            header.graphics.beginFill(0x000000);
            header.graphics.drawRect(0, 22, 550, 2);

            header.addChild(getTitle());
            header.addChild(getMessage());

            return header;
        }

        private static function getTitle():TextField
        {
            var titleFmt:TextFormat = new TextFormat();
            titleFmt.font = "Futura";
            titleFmt.color = 0xFFFFFF;
            titleFmt.size = 16;
            titleFmt.bold = true;

            var title:TextField = new TextField();
            title.name = "title";
            title.x = 4;
            title.y = 2;
            title.width = 200;
            title.selectable = false;
            title.defaultTextFormat = titleFmt;

            return title;
        }

        public static function getFooter():Sprite
        {
            var footer:Sprite = new Sprite();

            footer.addChild(getPage());
            footer.addChild(getArrows());

            return footer;
        }

        private static function getPage():TextField
        {
            var pageFmt:TextFormat = new TextFormat();
            pageFmt.font = "Futura";
            pageFmt.color = 0x000000;
            pageFmt.size = 16;
            pageFmt.bold = true;

            var page:TextField = new TextField();
            page.name = "page";
            page.x = 8;
            page.y = 366;
            page.width = 200;
            page.selectable = false;
            page.alpha = 0.4;
            page.defaultTextFormat = pageFmt;

            return page;
        }

        private static function getArrows():TextField
        {
            var pageFmt:TextFormat = new TextFormat();
            pageFmt.font = "Futura";
            pageFmt.color = 0x000000;
            pageFmt.size = 16;
            pageFmt.bold = true;

            var page:TextField = new TextField();
            page.name = "page";
            page.x = 510;
            page.y = 366;
            page.width = 200;
            page.selectable = false;
            page.alpha = 0.3;
            page.defaultTextFormat = pageFmt;
            page.text = "<   >";

            return page;
        }
        
        private static function getMessage():TextField
        {
            var messageFmt:TextFormat = new TextFormat();
            messageFmt.font = "Futura";
            messageFmt.color = 0xFFFFFF;
            messageFmt.size = 12;

            var message:TextField = new TextField();
            message.name = "status";
            message.x = 345;
            message.y = 5;
            message.width = 200;
            message.selectable = false;
            message.autoSize = TextFieldAutoSize.RIGHT;
            message.defaultTextFormat = messageFmt;

            return message;
        }

        public static function createInstrunctions():TextField
        {
            var messageFmt:TextFormat = new TextFormat();
            messageFmt.font = "Futura";
            messageFmt.size = 12;
            messageFmt.bold = true;

            var message:TextField = new TextField();
            message.name = "status";
            message.width = 200;
            message.selectable = false;
            message.defaultTextFormat = messageFmt;

            return message;
        }
    }
}
