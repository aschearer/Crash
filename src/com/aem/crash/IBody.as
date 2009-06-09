
package com.aem.crash
{

    import flash.geom.Point;

    /**
     * An object which has extension.
     *
     * @author Alexander Schearer <aschearer@gmail.com>
     */
    public interface IBody
    {

        /**
         * @return The top left x coordinate.
         */
        function getX():Number;

        /**
         * @return The top left y coordinate.
         */
        function getY():Number;

        /**
         * @return Number The width of the body.
         */
        function getWidth():Number;

        /**
         * @return Number The height of the body.
         */
        function getHeight():Number;
    }
}
