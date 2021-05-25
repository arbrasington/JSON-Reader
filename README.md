# JSON-Reader
The MATLAB JSON reader is utilized for extracting global and packets of data from exports from the neXtC software developed at the University of South Carolina McNair Aerospace Center.

The format of the json file should be in the form of "packets" of information, where each packet can have multiple attributes.

An example of this structure is provided below. Here each packet has an ID (0, 1, ...) and each packet has the attributes Coordinates, Curvature, and Local Stacking. The reader will extract this data into an array where each row will be a packet with a column for each value given.

    {
        "0": {
            "Coordinates": [
                128.57974044520964,
                298.24517841131626,
                78.0756268055863
            ],
            "Curvature": -5.54906472115015e-07,
            "Local Stacking": [
                0.0,
                0.0,
                0.0,
                0.0,
                0.0,
                0.0
            ]
        },
        "1": {
            "Coordinates": [
                128.79029084296965,
                285.97350038994443,
                79.46930611606973
            ],
            "Curvature": -5.8330313311404e-07,
            "Local Stacking": [
                0.0,
                0.0,
                0.0,
                0.0,
                0.0,
                0.0
            ]
        }, ...
