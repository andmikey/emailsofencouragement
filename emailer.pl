#!/usr/bin/perl
use strict;
use warnings;
use File::Slurp;
use Email::MIME;
use Email::Sender::Simple qw(sendmail);

# Choose a random encouraging message
my @lines = read_file("contents.txt", chomp => 1);
my $contents = $lines[rand @lines];

# Choose title
my $title = 'Frontend, we meet again';
# Email to send to
my $to_email = read_file('to_email.txt');
# Email to send from
my $from_email = read_file('from_email.txt');

# Create message
my $message = Email::MIME->create(
  header_str => [
    From    => $from_email,
    To      => $to_email,
    Subject => $title,
  ],
  attributes => {
    encoding => 'quoted-printable',
    charset  => 'UTF-8',
  },
  body_str => $contents,
);

# Send message
sendmail($message)
