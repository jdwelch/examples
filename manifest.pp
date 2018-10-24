genesis::template::resourcea { 'IntegrationTest-ResourceA':
  ensure       => present,
  mandatory    => 'mandatory string from manifest A',
}

genesis::restprovider::resourcea { 'REST Provider ResourceB':
  ensure       => present,
  mandatory    => 'mandatory string from manifest B',
}
