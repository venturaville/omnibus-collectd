#
# Copyright:: Copyright (c) 2013 Robby Dyer
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
name "liboping"
default_version "1.6.2"

source :url => "http://verplant.org/liboping/files/liboping-1.6.2.tar.gz",
       :md5 => "6f3e0d38ea03362476ac3be8b3fd961e"

relative_path "liboping-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}",
}

build do
  command [
            "./configure --without-perl-bindings",
            "--prefix=#{install_dir}/embedded",
           ].join(" "), :env => env

  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
  command "rm #{install_dir}/embedded/bin/noping"
end
