
package com.aem.crash {

    import flash.display.Graphics;
    import flash.geom.Point;
    import flash.utils.Dictionary;

    /**
     * Answer physical queries about a set of bodies.
     *
     * @author Alexander Schearer <aschearer@gmail.com>
     */
    public class Grid {

        // Maximum number of cells across, used for hashing
        private const MAX_WIDTH:uint = 50;

        private var cellWidth:uint;
        private var cellHeight:uint;
        private var cells:Dictionary;

        private var cached:Boolean;
        private var narrow:NarrowPhase;

        /**
         * Create a new grid with cells the given size.
         */
        public function Grid(width:uint, height:uint):void
        {
            cellWidth = width;
            cellHeight = height;
            cells = new Dictionary();
            narrow = new NarrowPhase();
        }

        public function get caching():Boolean 
        {
            return cached;
        }

        /**
         * Defaults to false, when caching is disabled partition is called
         * automatically by sweep, cull, and neighborhood.
         */
        public function set caching(value:Boolean):void
        {
            cached = value;
        }

        /**
         * Partitions the bodies according to their position in space.
         * @see caching
         *
         * @param bodies Array List of bodies to partition
         */
        public function partition(bodies:Array):void 
        {
            clear();
            for (var i:uint = 0; i < bodies.length; i++)
            {
                box(bodies[i]);
            }
        }

        /**
         * Sweeps bodies looking for intersections, calls the given handler when
         * an intersection is found.
         *
         * @param bodies Array List of bodies to test
         * @param response Function response(b1:IBody, b2:IBody):void
         */
        public function sweep(bodies:Array, response:Function):void
        {
            if (!caching)
                partition(bodies);
            var obstacles:Array = [];
            for (var key:String in cells)
            {
                obstacles = obstacles.concat(cells[key]); // obstacles is empty
                for (var i:uint = 0; i < cells[key].length; i++)
                {
                    obstacles.shift(); // don't check body against itself
                    var body:IBody = cells[key][i];
                    testAndRespond(body, obstacles, response);
                }
            }
        }

        /**
         * Returns the bodies in the neighborhood around the given body.
         *
         * @param body IBody Find the neighbors for this body
         * @param bodies Array List of bodies to test
         * @return Array The list of neighboring bodies
         */
        public function neighborhood(body:IBody, bodies:Array):Array
        {
            if (!caching)
                partition(bodies);

            var x:int = body.getX();
            var y:int = body.getY();
            var w:int = body.getWidth() - 1;
            var h:int = body.getHeight() - 1;

            var results:Array = [];
            for (var i:int = gridX(x) - 1; i <= gridX(x + w) + 1; i++)
            {
               for (var j:int = gridY(y) - 1; j <= gridY(y + h) + 1; j++)
               {
                   results = Utils.merge(results, getCell(i, j));
               }
            }
            Utils.remove(results, body);
            return results;
        }

        /**
         * Return the bodies which intersect with the given body.
         *
         * @param body IBody Find the neighbors for this body
         * @param bodies Array List of bodies to test
         * @return Array The list of neighboring bodies
         */
        public function cull(body:IBody, bodies:Array):Array
        {
            partition(bodies);

            var x:int = body.getX();
            var y:int = body.getY();
            var w:int = body.getWidth() - 1;
            var h:int = body.getHeight() - 1;

            var results:Array = [];
            for (var i:int = gridX(x); i <= gridX(x + w); i++)
            {
                for (var j:int = gridY(y); j <= gridY(y + h); j++)
                {
                    var intersecting:Array = testAndReturn(body, getCell(i, j));
                    results = Utils.merge(results, intersecting);
                }
            }

            return results;
        }

        /**
         * Draws wireframes for each body, useful for debugging.
         *
         * @param g Graphics The graphics resource used to draw the wireframes
         */
        public function debug(g:Graphics):void
        {
            g.clear();
            g.lineStyle(1, 0x000000, 1);
            for (var key:String in cells)
            {
                for (var i:uint = 0; i < cells[key].length; i++)
                {
                    var b:IBody = cells[key][i];
                    g.drawRect(b.getX(), b.getY(), b.getWidth(), b.getHeight());
                }
            }
        }

        // returns a list of bodies which intersect with the given body
        private function testAndReturn(body:IBody, obstacles:Array):Array {
            var intersecting:Array = new Array();
            for (var i:uint = 0; i < obstacles.length; i++) {
                if (narrow.intersecting(body, obstacles[i])) {
                    intersecting.push(obstacles[i]);
                }
            }
            return intersecting;
        }

        // calls the given handler each time an intersection is found
        private function testAndRespond(body:IBody, 
                obstacles:Array,
                response:Function):void
        {
            for (var i:uint = 0; i < obstacles.length; i++)
            {
                if (narrow.intersecting(body, obstacles[i]))
                    response(body, obstacles[i]);
            }
        }

        // clears each cell such that the grid is empty
        private function clear():void
        {
            for (var key:String in cells) 
            {
                if (cells[key].length == 0)
                    delete cells[key];
                else 
                    cells[key] = [];
            }
        }

        // places a body into any cell in which it extends
        private function box(body:IBody):void
        {
            var x:int = body.getX();
            var y:int = body.getY();
            var w:int = body.getWidth() - 1;
            var h:int = body.getHeight() - 1;

            for (var i:int = gridX(x); i <= gridX(x + w); i++)
            {
                for (var j:int = gridY(y); j <= gridY(y + h); j++)
                {
                    getCell(i, j).push(body);
                }
            }
        }

        // translates a x coordinate to a column in the grid
        private function gridX(x):int 
        {
            return Math.floor(x / cellWidth);
        }

        // translates a y coordinate to a row in the grid
        private function gridY(y):int 
        {
            return Math.floor(y / cellHeight);
        }

        private function checkCellExists(x:int, y:int):Boolean
        {
            return cells[x + y * MAX_WIDTH];
        }

        // returns a cell for the given coordinate
        private function getCell(x:int, y:int):Array
        {
            var cell:Array = cells[x + y * MAX_WIDTH];
            if (cell == null)
            {
                cell = [];
                cells[x + y * MAX_WIDTH] = cell;
            }
            return cell;
        }
    }
}
