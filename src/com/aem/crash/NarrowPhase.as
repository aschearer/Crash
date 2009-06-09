
package com.aem.crash
{

    /**
     * Handles narrow phase intersection testing.
     *
     * @author Alexander Schearer <aschearer@gmail.com>
     */
    class NarrowPhase
    {

        /**
         * @return Boolean True if the two bodies intersect.
         */
        public function intersecting(one:IBody, two:IBody):Boolean {
            var left1 = one.getX();
            var top1 = one.getY();
            var right1 = left1 + one.getWidth();
            var bottom1 = top1 + one.getHeight();

            var left2 = two.getX();
            var top2 = two.getY();
            var right2 = left2 + two.getWidth();
            var bottom2 = top2 + two.getHeight();

            if (bottom1 < top2) {
                return false;
            }
            if (top1 > bottom2) {
                return false;
            }
            if (right1 < left2) {
                return false;
            }
            if (left1 > right2) {
                return false;
            }
            return true;
        }
        
    }
}
