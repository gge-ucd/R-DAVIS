---------------------------------------------------------------------
Meteorology Measurements from the NOAA/ESRL/GMD Baseline Observatories

National Oceanic and Atmospheric Administration
Oceanic and Atmospheric Research
Earth System Research Laboratory
Global Monitoring Division


--------------------------------------------------------------------
1. DATA SOURCE AND CONTACTS

These directories contain meteorology measurements
at Barrow, Alaska (BRW); Mauna Loa, Hawaii (MLO); American
Samoa (SMO); Summit, Greenland (SUM); Trinidad Head, California (THD)
and South Pole, Antarctica (SPO), 

Correspondence concerning these data should be directed to:

Brian Vasel
NOAA ESRL Global Monitoring Division
325 Broadway, GMD-1
Boulder, Colorado, 80305 USA
Telephone: 303 497-6655
Electronic Mail: brian.vasel@noaa.gov

GMD.MET@noaa.gov
NOAA ESRL GMD

--------------------------------------------------------------------
2. USE OF DATA

These data are made freely available to the public and the
scientific community in the belief that their wide dissemination
will lead to greater understanding and new scientific insights.
The availability of these data does not constitute publication
of the data.  NOAA relies on the ethics and integrity of the user to
assure that ESRL receives fair credit for their work.  If the data
are obtained for potential use in a publication or presentation,
ESRL should be informed at the outset of the nature of this work.
If the ESRL data are essential to the work, or if an important
result or conclusion depends on the ESRL data, co-authorship
may be appropriate.  This should be discussed at an early stage in
the work.  Manuscripts using the ESRL data should be sent to ESRL
for review before they are submitted for publication so we can
insure that the quality and limitations of the data are accurately
represented.

--------------------------------------------------------------------
3. WARNINGS

Every effort is made to produce the most accurate and precise
measurements possible.  However, we reserve the right to make
corrections to the data based on recalibration of instruments
or for other reasons deemed scientifically justified.

We are not responsible for results and conclusions based on use
of these data without regard to this warning.

--------------------------------------------------------------------
4. UPDATE NOTES

===================================================================
2012-08-14

Initial release of data in format described in this README.  


-------------------------------------------------------------------
5. DATA - GENERAL COMMENTS

5.1 DATA - SAMPLING LOCATIONS

<A HREF='http://www.esrl.noaa.gov/gmd/dv/site/site_table.html#Met'>
Meteorology.</A>

The table includes the three letter code used to identify each
site; the site name; latitude, longitude, and elevation (meters
above sea level) of the sampling location; and country.

To view near real-time data, manipulate and compare data, please visit

<A HREF='http://www.esrl.noaa.gov/gmd/dv/iadv/'>http://www.esrl.noaa.gov/gmd/dv/iadv/</A>.


-------------------------------------------------------------------
5.2 DATA - FILE NAME DESCRIPTION

Encoded into each file name are the parameter (trace gas identifier); sampling
site; sampling project; laboratory ID number; measurement group; and optional
qualifiers that further define the file contents.

All file names use the following naming scheme:


         1         2               3                   4                     5                     6
met_[site]_[project]_[lab ID number]_[measurement group]_[optional qualifiers].txt

1. [site]

   Identifies the sampling site code.

   (ex)
   brw
   mlo
   smo
   spo

2. [project]

   Identifies sampling platform and strategy.

   (ex)
   insitu

3. [lab ID number]

   A numeric field that identifies the measurement laboratory (1,2,3, ...).
   NOAA ESRL is lab number 1 (see http://www.esrl.noaa.gov/gmd/ccgg/globalview/gv_labs.html).

4. [measurement group]

   Identifies the group within NOAA/ESRL/GMD that makes the actual measurement.

   (ex)
   obop

5. [optional qualifiers]

   Optional qualifier(s) may indicate data subsetting or averaging.
   Multiple qualifiers are delimited by an underscore (_).

   (ex)
   hour_####     Computed hourly averages for the specified 4-digit year
   month_####_## Computed minute averages for the specified 4-digit year, and 2 digit month

(ex)

met_brw_insitu_1_obop_hour_1998.txt
     - Hourly averages meteorological data from Barrow, Alaska for 1998.

met_brw_insitu_1_obop_minute_1998_06.txt
     - Minute averaged meteorological data from Barrow, Alaska for June 1998.

-------------------------------------------------------------------
5.3 DATA - HOURLY AVERAGES

The hourly average data files are text files that contain 
meteorological observations, one line for each hour of the 
year, for an individual observatory.

The data format is as follows:

xxx yyyy mm dd hh  www  ss.s ff pppp.pp   tt.t   tt.t   tt.t  uu  rr

Fields in each line are delimited by whitespace.  Fields are defined as follows:

Field 1:    [SITE CODE] 
            The three-character sampling location code (see above).

Field 2:    [YEAR] The sample collection date and time in UTC.
Field 3:    [MONTH]
Field 4:    [DAY]
Field 5:    [HOUR]
            The hour is from 0 to 23, and signifies the beginning of the hour.
            For example, hour 05 is from time 05:00 to 05:59.

Field 6:    [WIND DIRECTION] 
            Average wind direction from which the wind is blowing, 
            measured clockwise in degrees from true north.  
            North is 0 degrees, east 90 degrees, south 180, west 270
            Missing values are denoted by -999

Field 7:    [WIND SPEED] 
            Units are meters/second.
            Missing values are denoted by -999.9

Field 8:    [WIND STEADINESS FACTOR]
            The wind steadiness factor is 100 times the ratio of the vector wind
            speed to the average wind speed for the hour.
            Missing values are denoted by -9

Field 9:    [BAROMETRIC PRESSURE] 
            Units are hPa
            The station pressure is not corrected for elevation in any way. 
            Missing values are denoted by -999.90

Field 10:   [TEMPERATURE at 2 Meters] 
            Temperature at 2 meters above ground level. 
            Units are degrees Celsius.
            Missing values are denoted by -999.9

Field 11:   [TEMPERATURE at 10 Meters] 
            Temperature at 10 meters above ground level.
            Units are degrees Celsius.
            Missing values are denoted by -999.9

Field 12:   [TEMPERATURE at Tower Top] 
            Temperature at top of instrument tower. This elevation will vary 
            depending on the site.
            Units are degrees Celsius.
            Missing values are denoted by -999.9

Field 13:   [RELATIVE HUMIDITY] Units are in percent.
            Missing values are denoted by -99

Field 14:   [PRECIPITATION INTENSITY] Amount of precipitation per hour.  
            The precipitation amount is measured with an unheated tipping 
            bucket rain gauge. 
            Units are millimeters/hour.
            Missing values are denoted by -99


(ex)

BRW 1992 12 30 20   44    5.4 -9 1005.80  -21.9 -999.9 -999.9  80   0

SPO 1993 05 06 00   95    4.5 -9  667.80  -67.8 -999.9 -999.9 -99   0

-------------------------------------------------------------------
5.4 DATA - MINUTE AVERAGES

Within each site directory, there may be additional subdirectories with
names indicating a single year.  Inside the yearly directories are additional
files of minute averaged meteorological data, one file per month. The format of
these files is the same as the hourly averaged files, except for one additional
field indicating the minute of the hour (0-59).  This field is inserted between the
HOUR and WIND DIRECTION fields.

The data format for minute average files is as follows:

xxx yyyy mm dd hh nn  www  ss.s ff pppp.pp   tt.t   tt.t   tt.t  uu  rr

where nn is the minute of the hour. The minute value signifies the beginning of 
the minute, for example, hour 5, minute 12 is from 05:12:00 to 05:12:59

-------------------------------------------------------------------
5.5 DATA - QUALITY SCREENING

Data are screened for instrument malfunctions and non-physical values, 
both by visual inspection by GMD staff as well as automated algorithms.

-------------------------------------------------------------------
6. REFERENCES


Mefford, T.K., M. Bieniulis, B. Halter, and J. Peterson,
Meteorological Measurements, in CMDL Summary Report 1994 - 1995,
No. 23, 1996, pg. 17.

Herbert, G., M. Bieniulis, T. Mefford, and K. Thaut, Acquisition
and Data Management Division, in CMDL Summary Report 1993,
No. 22, 1994, pg. 57

Herbert, G.A., J. Harris, M. Bieniulis, and J. McCutcheon, 
Acquisition and Data Management, in CMDL Summary Report 
1989, No. 18, 1990, Pg. 50.

Herbert, G.A., E.R. Green, G.L. Koenig, and K.W. Thaut, 
Monitoring instrumentation for the continuous measurement 
and quality assurance of meteorological observations, NOAA 
Tech. Memo. ERL ARL-148, 44 pp, 1986.

Herbert, G.A., E.R. Green, J.M. Harris, G.L. Koenig, S.J. 
Roughton, and K.W. Thaut, Control and Monitoring 
Instrumentation for the Continuous Measurement of 
Atmospheric CO2 and Meteorological Variables, J. of Atmos. 
and Oceanic Tech., 3, 414-421, 1986.   

-------------------------------------------------------------------
