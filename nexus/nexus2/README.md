# README

The maintain commands

- `docker run -it --rm -v nexus2_data:/volume -v $(pwd):/backup alpine tar -cjf /backup/nexus2-backup.tar.bz2 -C /volume ./`
- `docker run -it --rm -v nexus2_data:/volume -v $(pwd):/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/nexus2-backup.tar.bz2"`

Mirror

- Central: <https://repo1.maven.org/maven2/>
- jcenter: <https://jcenter.bintray.com/>
- gradle-plugin: <https://plugins.gradle.org/m2/>
