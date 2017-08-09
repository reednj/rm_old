# rm_old
rm_old deletes old files

## Usage

Installation:

    $ gem install rm_old

Options:

        rm_old --age=n [--test] <files> (c) 2016 @reednj
        Options:
        -a, --age=<s>    delete any files older than this (ex. 1d, 36h)
        -t, --test       print the list of matched files, but don't delete
        -v, --version    Print version and exit
        -h, --help       Show this message

Examples:

    # delete all .gz files older than 14 days
    rm_old -a 14d *.gz

    # delete all files older than 2 hours
    rm_old --age 2h *

    # same as before but will print a list of what would be deleted
    rm_old --test --age 2h *

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

