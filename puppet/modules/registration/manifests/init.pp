class registration {
  exec { "unzip" :
    command   => "unzip -q -o ${deployablesDirectory}/registration.zip -d ${registrationAppDirectory}",
    provider  => shell
  }
}