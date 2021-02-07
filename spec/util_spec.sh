Describe 'util.sh'
  Include lib/util.sh

  # It 'err'
  #   When call Lib_Util_err
  #   The output should equal 'example error'
  #   The status should eq 0
  # End
  It 'output has param'
    When call Lib_Util_output 'test massage'
    The output should equal 'test massage'
    The status should eq 0
  End
  It 'get_os_type'
    When call Lib_Util_get_os_type
    The output should equal 'osx'
    The status should eq 0
  End
  It 'is_x86'
    When call Lib_Util_is_x86_64
    The status should eq 1
  End
  It 'is_arm64'
    When call Lib_Util_is_arm64
    The status should eq 0
  End
  It 'is_osx'
    When call Lib_Util_is_osx
    The status should eq 0
  End
  It 'is_linux'
    When call Lib_Util_is_linux
    The status should eq 1
  End
  It 'is_bsd'
    When call Lib_Util_is_bsd
    The status should eq 1
  End
  # It 'is_bash'
  #   When call Lib_Util_is_bash
  #   The status should eq 1
  # End
  # It 'is_zsh'
  #   When call Lib_Util_is_zsh
  #   The status should eq 0
  # End
  It 'is_fish'
    When call Lib_Util_is_fish
    The status should eq 1
  End
  It 'is_empty blank param'
    When call Lib_Util_is_empty ''
    The status should eq 0
  End
  It 'get_linux_distribution' 
    When call Lib_Util_get_linux_distribution
    The status should eq 1
    The output should eq 'This distribution is not supported'
  End
  It 'has not installed command'
    When call Lib_Util_has test_command
    The status should eq 1
  End 
  It 'has installed command'
    When call Lib_Util_has bash
    The status should eq 0
  End 
  It 'has_path not exist'
    When call Lib_Util_has_path '/test/test'
    The status should eq 1
  End
  It 'has_path exist'
    When call Lib_Util_has_path '/usr/bin'
    The status should eq 0
  End
  It 'usage no args'
    When call Lib_Util_usage
    The status should eq 0
    The stderr should eq 'Usage: /bin/sh '
  End
  It 'usage has args'
    When call Lib_Util_usage 'test error massage'
    The status should eq 0
    The stderr should eq 'Usage: /bin/sh test error massage'
  End

End