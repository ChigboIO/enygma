# Enygma [![Coverage Status](https://coveralls.io/repos/andela-echigbo/enygma/badge.svg?branch=master&service=github)](https://coveralls.io/github/andela-echigbo/enygma?branch=master) [![Circle CI](https://circleci.com/gh/andela-echigbo/enygma.svg?style=shield)](https://circleci.com/gh/andela-echigbo/enygma) [![Code Climate](https://codeclimate.com/github/andela-echigbo/enygma/badges/gpa.svg)](https://codeclimate.com/github/andela-echigbo/enygma)

Enygma is an encryption engine built (as a gem) with ruby programming language. It follows the principles of [Enigma Encryption Machine](https://en.wikipedia.org/wiki/Enigma_machine) to encrypt and decrypt files. The gem also offers the feature of cracking a file.

## How the encryption works

The encryption is based on rotation of letters using a key and the date of the encryption. The character map is made up of lower case alphabets (a - z), numbers(0 - 9), space character, comma, and period characters.

### The Key

* Each message uses a unique encryption key
* The key is five digits, like 41521
* The first two digits of the key are the "A" rotation (41)
* The second and third digits of the key are the "B" rotation (15)
* The third and fourth digits of the key are the "C" rotation (52)
* The fourth and fifth digits of the key are the "D" rotation (21)

### The Offset

* The date of message transmission is also factored into the encryption
* Consider the date in the format DDMMYY, like 020315
* Square the numeric form (412699225) and find the last four digits (9225)
* The first digit is the "A offset" (9)
* The second digit is the "B offset" (2)
* The third digit is the "C offset" (2)
* The fourth digit is the "D offset" (5)

## Installation

To install as a gem and run as a termina/command line program, run the following command in you terminal(command promt for Windows)

    $ gem install enygma

If you want to use 'Enygma' in your ruby application, add this line to your application's Gemfile:

```ruby
gem 'enygma'
```

And then execute:

    $ bundle


## Usage

This gem provides you with three command line actions, `encrypt`, `decrypt`, and `crack`

When you have installed the enygma gem, you can encrypt a file by changing to the directory that contantains the file, and run any of the following commands

#### Encryption
    $ encrypt <filename> [<destination-filename>]

#### Decryption
    $ decrypt <cypher-filename> [<plain-filename>] <key> <date>

#### Cracking
    $crack <cypher-filename> [<plain-filename>] <date>

## Options
`<filename>`    The file path of the of the file you want to encrypt. This can be the absolute filepath if you are in a different directory.

`<destination-filename>`    This is optional. If provided, is tThe filename where the encrypted text will the saved. Otherwise, the filename is deduce from the source `filename`

`<cypher-filename>` The filename/filepath to the encrypted file you want decrypt.

`<plain-filename>`  The destination filename to save the plain text. Optional. If not provided, the plain text is stored is a file with name coined from the `cypher-filename`

`<key>` A randomly generated unique 5 digits number used to encrypt the file. The key is displayed to you on a confirmation message when you encrypted the file.

`<date>`    The date the file was encrypted. This will also be displayed in a confirmation message in the terminal in the format, `ddmmyy`

## Example Usage

To encrypt a file name `file.txt`, and in whose containing I have changed to

    $ encrypt file.txt

    =>#Created file.encrypted.txt with the key 12345 and date 231190

    $ encrypt file.txt encrypted.txt

    =>#Created encrypted.txt with the key 12345 and date 231190

To decrypt a file named `file.encrypted.txt`

    $ decrypt file.encrypted.txt 12345 231190

    =>#Created file.decrypted.txt with key 12345 and date 231190

To crack a file named `file.encrypted.txt`

    $ crack file.encrypted.txt 231190

    =>#Created file.cracked.txt with key 12345 and date 231190


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-echigbo/enygma. This project is intended to be a safe and welcoming space for collaboration. To contribute to this work:

1. Fork it ( https://github.com/[andela-echigbo]/enygma/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. Wait

## Limitations
* The character set of this gem is limited; lower case alphabets, numbers, space, comma and period characters.
* The application generates the the key for the encryption, and does not allow user to choose their prefered digit combinations

## Improvement
* The character set suported by the gem will be increased
* The application should able to allow users choose their encryption key upon encrypting a file