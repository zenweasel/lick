/*

    LiCK  Library for ChucK.
    Copyright (c) 2007-2012 held jointly by the individual authors.

    This file is part of LiCK.

    LiCK is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    LiCK is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with LiCK.  If not, see <http://www.gnu.org/licenses/>.

*/

public class TriTrem extends Chugen
{
    TriOsc lfo;

    {
        lfo => blackhole;
    }

    fun float rate(float rate)
    {
        rate => lfo.freq;
        return rate;
    }

    fun float depth(float depth)
    {
        depth => lfo.gain;
        return depth;
    }

    fun float tick(float in)
    {
        interp(lfo.last(), -1.0, 1.0, 0.0, 1.0) => gain;
        return in;
    }

    fun float interp(float value, float sourceMin, float sourceMax, float targetMin, float targetMax)
    {
        return targetMin + (targetMax - targetMin) * ((value - sourceMin) / (sourceMax - sourceMin));
    }
}
