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

class CompositeSampleProcedure extends Procedure
{
    Sample @ sample;

    fun void run()
    {
        sample.play();
    }
}

class CompositeSampleIntProcedure extends IntProcedure
{
    Sample @ sample;
    0 => int minGain;
    127 => int maxGain;

    fun void run(int gain)
    {
        sample.minGain + ((gain $ float) / ((minGain + maxGain) $ float)) * (sample.maxGain - sample.minGain) => sample.gain;
        sample.play();
    }
}

class CompositeSampleIntIntProcedure extends IntIntProcedure
{
    Sample @ sample;
    0 => int minGain;
    127 => int maxGain;
    0 => int minRate;
    127 => int maxRate;

    fun void run(int rate, int gain)
    {
        sample.minRate + ((rate $ float) / ((minRate + maxRate) $ float)) * (sample.maxRate - sample.minRate) => sample.rate;
        sample.minGain + ((gain $ float) / ((minGain + maxGain) $ float)) * (sample.maxGain - sample.minGain) => sample.gain;
        sample.play();
    }
}

class CompositeSampleFloatProcedure extends FloatProcedure
{
    Sample @ sample;

    fun void run(float gain)
    {
        gain => sample.gain;
        sample.play();
    }
}

class CompositeSampleFloatFloatProcedure extends FloatFloatProcedure
{
    Sample @ sample;

    fun void run(float rate, float gain)
    {
        rate => sample.rate;
        gain => sample.gain;
        sample.play();
    }
}

public class CompositeSample extends Sample
//    implements Procedure, IntProcedure, IntIntProcedure, FloatProcedure, FloatFloatProcedure
{
    ArrayList samples;

    // hack to simulate multiple inheritance
    CompositeSampleProcedure _compositeProcedure;
    CompositeSampleIntProcedure _compositeIntProcedure;
    CompositeSampleIntIntProcedure _compositeIntIntProcedure;
    CompositeSampleFloatProcedure _compositeFloatProcedure;
    CompositeSampleFloatFloatProcedure _compositeFloatFloatProcedure;

    {
        this @=> _compositeProcedure.sample;
        this @=> _compositeIntProcedure.sample;
        this @=> _compositeIntIntProcedure.sample;
        this @=> _compositeFloatProcedure.sample;
        this @=> _compositeFloatFloatProcedure.sample;
    }

    fun void play()
    {
        ((minGain + gain)/(maxGain) * samples.size()) $ int => int index;
        samples.get(index - 1) $ Sample @=> Sample sample;
        rate => sample.rate;
        gain => sample.gain;
        sample.play();
    }

    fun Procedure asProcedure()
    {
        return _compositeProcedure;
    }

    fun IntProcedure asIntProcedure()
    {
        return _compositeIntProcedure;
    }

    fun IntIntProcedure asIntIntProcedure()
    {
        return _compositeIntIntProcedure;
    }

    fun FloatProcedure asFloatProcedure()
    {
        return _compositeFloatProcedure;
    }

    fun FloatFloatProcedure asFloatFloatProcedure()
    {
        return _compositeFloatFloatProcedure;
    }
}