# Tirisfal

This is some stuff I use for spatial workflows in R that I'm packaging for
convinience. Central idea of the package is a config (list) object which keeps
track of the chosen files and metadata associated with a project, alongside the
objects themselves.

I can start a new report, specify the inputs and their paths using a json file
(or enter it manually in R), and create my config object. Custom properties in
form of key: value pairs are suppoed. It can then initiliase all of those files
into R based on their file extension, adding them to the config object. The
items/data can be a mix of different types, like `.csv` or `.geoJSON`.

Then I can operate on the objects using the config, and not have to worry about
setting up output folder paths and filenames, or assigning new objects, as the
config and helpers should take care of it.

It should be extensible to other uses as well.

## Key Functions

- `project_options()`: Sets up the project config/options and creates the directory structure if `setup = TRUE`.
- `import_options()`: Imports a complete project config specification from a JSON file.
- `import_items()`: Imports just a collection config specification from a JSON config file.
- `create_items()`: Create a collection config structure manually.
- `craft_items()`: Initialises the items in the collection (e.g. `terra::rast()` if `.tif`, `read_csv()` if .csv etc)

## License

This project is licensed under the MIT License. See the `LICENSE.md` file for details.
