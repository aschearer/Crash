
package com.aem.crash
{

    /**
     * Collection of utility methods for the grid.
     *
     * @author Alexander Schearer <aschearer@gmail.com>
     */
    class Utils
    {

        /**
         * Remove the given body from the list.
         *
         * @param list Array 
         * @param body IBody
         */
        public static function remove(list:Array, element:IBody):void
        {
            for (var i:uint = 0; i < list.length; i++)
            {
                if (list[i] == element)
                    list.splice(i, 1);
            }
        }

        /**
         * Merge two lists without duplicates.
         *
         * @param a1 Array
         * @param a2 Array
         * @return Array
         */
        public static function merge(a1:Array, a2:Array):Array
        {
            var result:Array = a1.concat([]);
            for (var i:uint = 0; i < a2.length; i++)
            {
                if (result.indexOf(a2[i]) == -1)
                    result.push(a2[i]);
            }
            return result;
        }

        public static function combine(list1:Array, list2:Array):void
        {
            for each (var item in list2)
            {
                list1.push(item);
            }
        }

    }
}
